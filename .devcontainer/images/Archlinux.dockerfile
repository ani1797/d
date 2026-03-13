FROM archlinux:latest

# Update package manager
RUN pacman -Syu --noconfirm

# Install essential utilities
RUN pacman -S --noconfirm \
    curl \
    wget \
    git \
    sudo \
    base-devel \
    ca-certificates \
    && pacman -Scc --noconfirm

# Set working directory
WORKDIR /workspace

# Default shell
CMD ["/bin/bash"]
