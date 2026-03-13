FROM alpine:latest

# Update package manager
RUN apk update && apk upgrade

# Install essential utilities
RUN apk add --no-cache \
    curl \
    wget \
    git \
    sudo \
    bash \
    build-base \
    ca-certificates

# Set working directory
WORKDIR /workspace

# Default shell
CMD ["/bin/bash"]
