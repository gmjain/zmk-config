FROM zmkfirmware/zmk-dev-arm:stable

# Install additional dependencies if needed
RUN apt-get update && apt-get install -y \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set up work directory
WORKDIR /app

# Copy the ZMK configuration
COPY . /app/config

# Set up the ZMK environment
RUN west init -l config
RUN west update
RUN west zephyr-export

# The actual build command will be run in the docker-compose file
CMD ["west", "build", "-b", "nice_nano_v2", "-d", "build/left", "config/boards/shields/rev57lp"]
