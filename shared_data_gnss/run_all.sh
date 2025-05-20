#!/bin/bash
echo "Running build_image.sh..."
./build_image.sh
sleep 5
echo "Running export_image.sh..."
./export_image.sh
sleep 5
echo "Running load_image.sh..."
cd images_loader
./load_image.sh

echo "All steps completed successfully."
