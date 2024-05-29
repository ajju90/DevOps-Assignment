# Use Ubuntu 16.04 as base image
FROM ubuntu:16.04

# Update package lists and install required packages
RUN apt-get update && \
    apt-get install -y telnet curl ffmpeg && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set default command to launch bash
CMD ["bash"]
