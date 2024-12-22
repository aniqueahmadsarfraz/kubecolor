#!/bin/bash

# Variables
KUBECOLOR_VERSION="0.4.0"
KUBECOLOR_TAR="kubecolor_${KUBECOLOR_VERSION}_linux_amd64.tar.gz"
KUBECOLOR_URL="https://github.com/kubecolor/kubecolor/releases/download/v${KUBECOLOR_VERSION}/${KUBECOLOR_TAR}"
DEFAULT_THEME="protanopia-dark"

# Function to update bashrc and reload
update_bashrc() {
    # Clear previous kubecolor settings from .bashrc
    sed -i '/alias kubectl=/d' ~/.bashrc
    sed -i '/KUBECOLOR_FORCE_COLOR=/d' ~/.bashrc
    sed -i '/KUBECOLOR_PRESET=/d' ~/.bashrc

    # Add new configurations to .bashrc
    echo "# Kubecolor settings" >> ~/.bashrc
    echo "export KUBECOLOR_FORCE_COLOR=1" >> ~/.bashrc
    echo "export KUBECOLOR_PRESET=${DEFAULT_THEME}" >> ~/.bashrc
    echo "alias kubectl='KUBECOLOR_FORCE_COLOR=1 KUBECOLOR_PRESET=${DEFAULT_THEME} kubecolor'" >> ~/.bashrc

    # Source bashrc in current shell and all parent shells
    if [ -f ~/.bashrc ]; then
        exec bash -l
    fi
}

# Function to update color.yaml
update_color_yaml() {
    # Create .kube directory if it doesn't exist
    mkdir -p ~/.kube

    # Check if color.yaml exists, if not create it
    if [ ! -f ~/.kube/color.yaml ]; then
        echo "Creating color.yaml with default theme..."
        echo "preset: ${DEFAULT_THEME}" > ~/.kube/color.yaml
    else
        # If it exists, ensure the correct preset is set
        sed -i "s/^preset:.*/preset: ${DEFAULT_THEME}/" ~/.kube/color.yaml
    fi
}

# Download kubecolor
echo "Downloading kubecolor version ${KUBECOLOR_VERSION}..."
wget $KUBECOLOR_URL -O $KUBECOLOR_TAR

# Extract the tarball
echo "Extracting $KUBECOLOR_TAR..."
tar -xvzf $KUBECOLOR_TAR

# Verify if the kubecolor binary is extracted
if [ -f "kubecolor" ]; then
    # Move the binary to /usr/local/bin
    echo "Moving kubecolor to /usr/local/bin..."
    sudo mv kubecolor /usr/local/bin/

    # Verify kubecolor installation
    if command -v kubecolor > /dev/null; then
        echo "kubecolor installed successfully!"
    else
        echo "Error: kubecolor installation failed."
        exit 1
    fi

    # Cleanup
    echo "Cleaning up..."
    rm $KUBECOLOR_TAR

    # Update bashrc and reload shell
    echo "Configuring kubecolor settings..."
    update_bashrc

    # Update color.yaml for default theme
    echo "Configuring color.yaml for default theme..."
    update_color_yaml

else
    echo "Error: kubecolor binary not found after extraction."
    exit 1
fi
