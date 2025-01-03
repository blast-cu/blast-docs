# CUDA Development Setup on WSL

## Links
- ### [NVIDIA Docs](https://docs.nvidia.com/cuda/wsl-user-guide/index.html)
- ### [CUDA Toolkit Download](https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&Distribution=WSL-Ubuntu&target_version=2.0&target_type=deb_local)


## Setup

This guide assumes you already have WSL2 and some Linux distro already installed. If this is not the case, please first run `wsl --install` and `wsl --install <distro-name>`

It is also assumed that you have a Pascal or newer NVIDIA GPU (10XX or newer). If not, you will likely be unable to develop and run any CUDA applications with this method.

1. Install the most recent GeForce Game Ready Driver or RTX Quadro Windows 11 display driver

2. If necessary, remove the old GPG key: 
    ```bash
    sudo apt-key del 7fa2af80
    ```

3. Download necessary installation files:
    ```bash
    wget https://developer.download.nvidia.com/compute/cuda/repos/wsl-ubuntu/x86_64/cuda-wsl-ubuntu.pin
    sudo mv cuda-wsl-ubuntu.pin /etc/apt/preferences.d/cuda-repository-pin-600
    wget https://developer.download.nvidia.com/compute/cuda/12.6.3/local_installers/cuda-repo-wsl-ubuntu-12-6-local_12.6.3-1_amd64.deb
    sudo dpkg -i cuda-repo-wsl-ubuntu-12-6-local_12.6.3-1_amd64.deb
    ```

4. Add the new GPG key: 
    ```bash
    sudo cp /var/cuda-repo-wsl-ubuntu-12-6-local/cuda-*-keyring.gpg /usr/share/keyrings/
    ```

5. Install the toolkit:
    ```bash
    sudo apt-get update
    sudo apt-get -y install cuda-toolkit-12-6
    sudo apt-get upgrade
    ```

6. Add the Toolkit to your PATH by copying the following into your .bashrc file:
    ```bash
    export PATH="/usr/local/cuda-12/bin:$PATH"
    export LD_LIBRARY_PATH="/usr/local/cuda-12/lib64:$LD_LIBRARY_PATH"
    ```

7. Source your .bashrc flie or restart WSL
    ```bash
    source ~/.bashrc
    ```

8. Develop CUDA applications using your preferred workflow and compile them using `nvcc`