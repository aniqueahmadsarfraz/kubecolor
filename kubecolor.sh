#!/bin/bash

# Variables
KUBECOLOR_VERSION="0.4.0"
KUBECOLOR_TAR="kubecolor_${KUBECOLOR_VERSION}_linux_amd64.tar.gz"
KUBECOLOR_URL="https://github.com/kubecolor/kubecolor/releases/download/v${KUBECOLOR_VERSION}/${KUBECOLOR_TAR}"

# Download kubecolor
echo "Downloading kubecolor version ${KUBECOLOR_VERSION}..."
wget $KUBECOLOR_URL -O $KUBECOLOR_TAR

# Extract the tarball
echo "Extracting $KUBECOLOR_TAR..."
tar -xvzf $KUBECOLOR_TAR

# Move the binary to /usr/local/bin
echo "Moving kubecolor to /usr/local/bin..."
sudo mv kubecolor /usr/local/bin/

# Set alias for kubectl
echo "Creating alias for kubectl as kubecolor..."
echo "alias kubectl='kubecolor'" >> ~/.bashrc

# Export preset environment variable
echo "Setting KUBECOLOR_PRESET to protanopia-dark..."
echo "export KUBECOLOR_PRESET='protanopia-dark'" >> ~/.bashrc

# Source the updated .bashrc
echo "Applying changes to shell..."
source ~/.bashrc

# Cleanup
echo "Cleaning up..."
rm $KUBECOLOR_TAR

# Confirmation
echo "kubecolor has been installed and configured successfully!"
