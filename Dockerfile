FROM zmkfirmware/zmk-dev-arm:stable

# Install additional dependencies if needed
RUN apt-get update && apt-get install -y \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set up work directory
WORKDIR /app

# Set environment variables
ENV ZEPHYR_BASE=/app/zephyr
ENV GNUARMEMB_TOOLCHAIN_PATH=/usr/local/arm-gnu-toolchain-12.2.rel1-x86_64-arm-none-eabi

# Create a non-root user
RUN useradd -m -u 1000 zmkuser
USER zmkuser

# Set the working directory to the user's home
WORKDIR /home/zmkuser
