FROM zmkfirmware/zmk-dev-arm:stable

# Install additional dependencies if needed
RUN apt-get update && apt-get install -y \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set up work directory
WORKDIR /app

# Set the entrypoint to bash
ENTRYPOINT ["/bin/bash"]
