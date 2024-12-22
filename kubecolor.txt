wget https://github.com/kubecolor/kubecolor/releases/download/v0.4.0/kubecolor_0.4.0_linux_amd64.tar.gz


tar -xvzf kubecolor_0.4.0_linux_amd64.tar.gz


sudo mv kubecolor /usr/local/bin/


alias kubectl="kubecolor"


export KUBECOLOR_PRESET="protanopia-dark"

preset: protanopia-dark