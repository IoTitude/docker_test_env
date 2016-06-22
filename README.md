# Dockerized continuous integration

## Docker Engine
[Docker Engine](https://docs.docker.com/engine/installation/) is required to build and run docker images.  
[Docker Compose](https://docs.docker.com/compose/install/) makes Dockerfile management easier and is required to run docker-compose files.  

## Jenkins
This Jenkins setup uses four dockerfiles: Jenkins master, slave, data volume and nginx proxy.  

If you want to pre install Jenkins plugins list them in jenkins/jenkins-master/plugins.txt

In Jenkins directory: 
```shell
# Builds images from the dockerfiles. Same as 'docker-compose build'.
make build

# Launch containers. Same as 'docker-compose up -d'.
make run
```

Now you have Jenkins running in containers and accessible at http://localhost/

To launch Jenkins in Rancher, use jenkins/rancher_docker-compose.yml. It uses ready images from dockerhub.

## Test slave
We want the test slave to pull the image from a repository. That way we can do updates on our images from anywhere and the test slave always uses the latest version.  

The slave container has access to the hosts docker socket, so it can launch test containers on the host.

## Configuring Test slave

Open Jenkins and go to Manage Jenkins > Manage Nodes > New Node  
Give it a name, select dumb slave and click OK.

In the configuration page:
* Set remote root directory to /var/jenkins_home
* Give it a label
* Usage: Only build jobs with label restrictions matching this node
* Launch method: Launch slave agents on Unix machines via SSH
* Save

Now the test slave is ready and can be used in a project.

## Test project
This example project has two items. One for launching Instapp as a webpage, and one for running tests against it.

* Go to jenkins and create a new item.
* Select Restrict where this project can be run and use the label you gave while creating the slave.  
* Add build step
* Execute shell
```shell
echo "Build starting..."
docker pull iotitude/ionic_env # Pulls the latest Instapp image if it is not already latest
export BUILD_ID=dontKillMe # By default processes launched by Jenkins build steps are killed after the build is finished
docker run -dt --name=instapp -p 8100:8100 iotitude/ionic_env # Runs Instapp in a container named instapp
```
Save and create a new item.
* Select Restrict where this project can be run and use the label you gave while creating the slave.  
* Build Triggers: Build after other projects are built: name of the first project.
* Add build step
* Execute shell
```shell
set +e # Set the script to not stop on error
rm -R /var/jenkins_home/volume # Deletes old test results if they exist
docker pull iotitude/firefox_test # Pulls the latest version of firefox test image
set -e
docker run --rm --name=tb --net host --volumes-from r-Jenkins_jenkinsmaster_jenkinsdata_1 iotitude/firefox_test # Run the firefox test image in a container named tb and give it volumes from the jenkins-data container
docker stop instapp # stop Instapp after tests are done
docker rm instapp
```
* Add post-build action
* Publish Robot Framework test results (Needs Robot Framework plugin)
* Directory of Robot output: /var/jenkins_home/volume
* Save

Jenkins-master and jenkins-slave use the shared data volume container jenkins-data. It is also given to firefox test container. That way we can keep the test results after the test container is stopped.





