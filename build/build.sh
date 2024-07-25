#!/bin/bash

# cd /zmk-config
# west update
# west zephyr-export
# cd /zmk-config/zmk/app
# west build -b nice_nano_v2 -- -DSHIELD="enki42_left enki42_right enki42_dongle" -DZMK_CONFIG="/zmk-config/config"
# cp /zmk-config/zmk/app/build/zephyr/zmk.uf2 /zmk-config/build/artifacts/firmware.uf2

cd /zmk-config
west update
west zephyr-export
cd /zmk-config/zmk/app

# Read build.yaml and extract board and shield combinations
mapfile -t configs < <(yq e '.include[] | .board + " " + .shield' /zmk-config/build.yaml)

# Create build directory if it doesn't exist
mkdir -p /zmk-config/build/artifacts

# Loop through each configuration and build firmware
for config in "${configs[@]}"; do
  read -r board shield <<<"$config"

  echo "Building firmware for $board with shield $shield"

  west build -p -b "$board" -- -DSHIELD="$shield" -DZMK_CONFIG="/zmk-config/config"

  # Copy the firmware file with a descriptive name
  chown -R 1000:1000 /zmk-config/zmk/app/build/zephyr/zmk.uf2
  cp /zmk-config/zmk/app/build/zephyr/zmk.uf2 "/zmk-config/build/artifacts/${board}_${shield}.uf2"

  # Clean the build directory for the next iteration
  west build -t pristine
done

chown -R 1000:1000 /zmk-config/build
echo "Build process completed."
