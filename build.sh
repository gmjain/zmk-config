#!/bin/bash

# Initialize and update west if not already done
if [ ! -d "zephyr" ]; then
    west init -l /app
    west update
    west zephyr-export
fi

# Build commands for both the keyboard and dongle firmware
west build -b nice_nano_v2 -d build/rev57lp config/boards/shields/rev57lp
west build -b nice_nano_v2 -d build/nice_nano_dongle config/boards/shields/nice_nano_dongle
