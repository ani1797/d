FROM ubuntu:latest

# Update package manager
RUN apt-get update && apt-get upgrade -y

# Install essential utilities
RUN apt-get install -y \
    curl \
    wget \
    git \
    sudo \
    build-essential \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /workspace

# Default shell
CMD ["/bin/bash"]
