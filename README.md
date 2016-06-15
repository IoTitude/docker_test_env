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

