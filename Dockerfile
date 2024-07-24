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

# Set the entrypoint to bash
ENTRYPOINT ["/bin/bash"]
