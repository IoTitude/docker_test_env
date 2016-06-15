# Dockerized continuous integration

## Docker Engine
[Docker Engine](https://docs.docker.com/engine/installation/) is required to build and run docker images.  
[Docker Compose](https://docs.docker.com/compose/install/) makes Dockerfile management easier and is required to run docker-compose files.  

## Jenkins
This Jenkins setup uses three dockerfiles: Jenkins master, data volume and nginx proxy.  

If you want to pre install Jenkins plugins list them in jenkins/jenkins-master/plugins.txt

In Jenkins directory: 
```shell
# Builds images from the dockerfiles. Same as 'docker-compose build'.
make build

# Launch containers. Same as 'docker-compose up -d'.
make run
```

Now you have Jenkins running in containers and accessible at http://localhost/

## Test slave
We want the test slave to pull the image from a repository. That way we can do updates on our images from anywhere and the test slave always uses the latest version.  

Navigate to firefox_env directory and run:
```shell
docker build -t yourdockerhub/firefox .
docker push yourdockerhub/firefox
```

The jenkins-master container has [Docker Machine](https://docs.docker.com/machine/overview/), which we use to create a slave docker host on Digitalocean.  

Use 'docker ps' to get the name or ID of jenkinsmaster and then run:
```shell
docker exec -it jenkinsmaster /bin/bash
```

Then as jenkins user run: 
```shell
docker-machine create --driver digitalocean --digitalocean-access-token=<DIGITALOCEANACCESSTOKEN> --digitalocean-image ubuntu-14-04-x64 --digitalocean-region ams2 TestSlave
```
This command creates a new Digitalocean droplet named TestSlave. To generate a Digitalocean access token log in to Digitalocean and choose > API > Tokens > Generate New Token.

Next we need to make the slave accessible for Jenkins.
```shell
cp ~/.docker/machine/machines/TestSlave/ /var/jenkins_home/
ssh <DROPLET ADDRESS> -lroot -i /var/jenkins_home/TestSlave/id_rsa 
```
```shell
cd /root
wget http://<JENKINSHOSTADDRESS>/jnlpJars/slave.jar
```
And install Java
```shell
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java8-installer
```
Then exit the slave.

## Configuring Test slave

Open Jenkins and go to Manage Jenkins > Manage Nodes > New Node  
Give it a name, select dumb slave and click OK.

In the configuration page:
* Set remote root directory to /root
* Give it a label
* Usage: Only build jobs with label restrictions matching this node
* Launch method: Launch slave via execution of command on the Master
  * ssh <DROPLET ADDRESS> -lroot -i /var/jenkins_home/TestSlave/id_rsa java -jar /root/slave.jar
* Save

Now the test slave is ready and can be used in a project.

## Test project

* Go to jenkins and create a new item.
* Select Restrict where this project can be run and use the label you gave while creating the slave.  
* Add build step
* Execute shell
  * docker pull yourdockerhub/firefox
  * docker run --rm --name=tbfirefox -v /root/workspace/Robot/volume:/home/root/volume yourdockerhub/firefox
* Add post-build action
* Publish Robot Framework test results (Needs Robot Framework plugin)
* Directory of Robot output: volume
* Save

In the docker run command
* --rm removes the container after it has stopped
* --name gives the container a name (not really needed here)
* -v creates a shared data volume between the test slave and the container. It is used to get the test results back from the container.
* yourdockerhub/firefox is the image we built and pushed to dockerhub in the beginning of this document.





