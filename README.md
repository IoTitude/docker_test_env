# Dockerized continuous integration

## Docker Engine
[Docker Engine](https://docs.docker.com/engine/installation/) is required to build and run docker images.  
[Docker Compose](https://docs.docker.com/compose/install/) makes Dockerfile management easier and is required to run docker-compose files.  

## Jenkins
This Jenkins setup uses three dockerfiles: Jenkins master, data volume and nginx proxy.  

In Jenkins directory: 
```shell
# Builds images from the dockerfiles. Same as 'docker-compose build'.
make build

# Launch containers. Same as 'docker-compose up -d'.
make run
```

Now you have Jenkins running in containers and accessible at http://localhost/

## Test slave
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
