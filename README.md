# DevOps-Assignment
# Q.1 Docker
This Docker image is based on Ubuntu 16.04 and includes the following packages:
- telnet
- curl
- ffmpeg

## Instructions

### Install Docker Engine on Ubuntu:
1. Install docker on your ubuntu system.
2. Follow these steps for install docker in your machine. Please refer official website of docker for installation [Docker's official website](https://docs.docker.com/engine/install/ubuntu/)
3. Save the provided `Dockerfile` to a directory on your machine.

4. **Build the Docker file using the following command :**
```bash
docker build -t devops-assignment .
```
5. **Run the Docker image**
```bash
docker run -it devops-assignment
```

## Verify the Installed Packages
Inside the running container, you can verify that the packages are installed correctly by running the following commands:
To check the installation of telnet :
  ```bash 
  telnet
```

**To check the installation of curl :**
  ```bash
curl --version
```

**To check the installation of ffmpeg :**
```bash
ffmpeg -version
```
You should see the version information for the all packages.

6. **Exit the Container :**
To exit the container, simply type exit and press Enter.

7. **To remove the Docker image from your system, follow command.**
 ```bash
docker rmi -f devops-assignment
```
8. **To remove any stopped containers, first list all containers to find the container ID or name.**
 ```bash
docker ps -a
``` 

9. **Then remove the container using.**
```bash
docker rm -f <container_id>
```


#  Q.2 Auditing Hardware

1. **Download the Script**:\
Save the script `hardware.sh` to your desire directory.

2. **Make the Script Executable**:\
Give the executable permission on hardware.sh file for use following command: 
```bash
 chmod +x hardware.sh
 ```
**Run the Script:**

```bash
./audit_hardware.sh
```


# Q.3 Managing Disk Space

**Overview**
The disk-space.sh script helps manage disk space by deleting .wav audio files in the /data/audios/folder directory that are older than a specified time threshold. By default, files older than 40 hours are deleted. The script logs the details of each deletion in a log file named deleted-files-<date>-<month>-<year>.log

1. **Download the Script**:\
Save the script `disk-space.sh` to your desire directory.

2. **Make the Script Executable**:\
Give the executable permission on disk-space.sh file for use following command: 
```bash
 chmod +x hardware.sh
 ```

3. **Run the Script:**

```bash
./audit_hardware.sh
```
**Check the logs file in current directory using command:**

```bash
ls
cat <log file name>
```

4.**Important Note**

Suppose your script is not run then check the proper path /data/audios/folder This path and disk.sh script path should match.
they are match then run your scipt is properly.



