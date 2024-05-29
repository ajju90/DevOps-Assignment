# DevOps-Assignment
# Docker Image with Ubuntu 16.04 and Essential Packages

This Docker image is based on Ubuntu 16.04 and includes the following packages:
- telnet
- curl
- ffmpeg

## Instructions

### Install Docker Engine on Ubuntu:
1. Install docker on your ubuntu system.
2. Follow these steps for install docker in your machine. Please refer official website of docker for installation [Docker's official website](https://docs.docker.com/engine/install/ubuntu/)
3. Save the provided `Dockerfile` to a directory on your machine.
4. Build the Docker file using the following command :
```bash
docker build -t devops-assignment .
```
6. Run the Docker image
```bash
docker run -it devops-assignment
```

## Verify the Installed Packages
Inside the running container, you can verify that the packages are installed correctly by running the following commands:
To check the installation of telnet :
  ```bash 
  telnet
```

To check the installation of curl :
  ```bash
curl --version
```

To check the installation of ffmpeg :
```bash
ffmpeg -version
```
You should see the version information for the all packages.

6. Exit the Container :
To exit the container, simply type exit and press Enter.

7. To remove the Docker image from your system, run.
 ```bash
docker rmi -f devops-assignment
```
9. To remove any stopped containers, first list all containers to find the container ID or name.
 ```bash
docker ps -a
``` 

10. Then remove the container using.
```bash
docker rm -f <container_id>
```







