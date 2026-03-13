FROM fedora:latest

# Update package manager
RUN dnf upgrade -y --refresh

# Install essential utilities
RUN dnf install -y \
    curl \
    wget \
    git \
    sudo \
    gcc \
    gcc-c++ \
    make \
    ca-certificates \
    && dnf clean all

# Set working directory
WORKDIR /workspace

# Default shell
CMD ["/bin/bash"]
