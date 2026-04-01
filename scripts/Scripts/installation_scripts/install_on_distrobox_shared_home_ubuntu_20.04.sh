#!/usr/bin/env bash
set -euo pipefail

#  Script should be executed with sudo

#  This script is meant to install all my dev tools on a new distrobox container sharing the home folder. Shell configs for instance will be shared with the host directly.
#  This implicates that the dev tools share the .config with the host. Meaning that while the versions can missmatch, their configs have to be compatible. 
#  This is mainly a concern towards Neovim.

# -----------------
#     Config
# -----------------

NVM_DIR="/usr/local/nvm"
NODE_VERSION="v22.12.0"

echo "Starting dev environment setup"

# -----------------------------
# Update and base system packages
# -----------------------------

echo "Installing base packages"

apt update && apt install -y \
    zsh stow bat  \
    pip git \
    vim curl wget wl-clipboard

# Required for Neovim
apt install -y \
    luarocks ripgrep black isort \
    neofetch iputils-ping

chsh -s $(which zsh)

# -----------------
#     Zoxide 
# -----------------

# Because zoxide is bugged in ubuntu 22.04
wget https://github.com/ajeetdsouza/zoxide/releases/download/v0.9.8/zoxide_0.9.8-1_amd64.deb -O /tmp/zoxide.deb
dpkg -i /tmp/zoxide.deb
rm /tmp/zoxide.deb

#------------------
#     Eza 
#------------------

apt install -y gpg
# This is the recommended way.
# https://github.com/eza-community/eza/blob/main/INSTALL.md#debian-and-ubuntu
mkdir -p /etc/apt/keyrings 
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
apt update && apt install -y eza


#------------------
#     NVIM 
#------------------ 

# I have to make sure LSPs are not installed on the host root, otherwise I will have to install them here too. Mason keeps them in ~/.local/share/nvim/mason/bin

cd /usr/bin

wget https://github.com/neovim/neovim/releases/download/v0.11.5/nvim-linux-x86_64.tar.gz -O nvim.tar.gz
tar xzf nvim.tar.gz
rm nvim.tar.gz
ln -sf nvim-linux-x86_64/bin/nvim /usr/bin/nvim

cd "$HOME"


#------------------
#     Neovide 
#------------------
# https://neovide.dev/installation.html
#

apt install -y curl \
    gnupg ca-certificates git \
    gcc-multilib g++-multilib cmake libssl-dev pkg-config \
    libfreetype6-dev libasound2-dev libexpat1-dev libxcb-composite0-dev \
    libbz2-dev libsndio-dev freeglut3-dev libxmu-dev libxi-dev libfontconfig1-dev \
    libxcursor-dev

# Get Rust
curl https://sh.rustup.rs -sSf | bash -s -- -y

# Add .cargo/bin to PATH
# Done in .zshrc but needs also here idk why exactly

PATH="${HOME}/.cargo/bin:${PATH}"
echo "${PATH}"

cargo install --git https://github.com/neovide/neovide

cargo install --locked tree-sitter-cli

# Required for AppImages
apt install fuse -y

## - - - - - - - - -
## Node (Required for NVIM)
## - - - - - - - - -

# Its a little messy because it needs to be sourced for nvm to be available as a command
# https://stackoverflow.com/a/62838796/8600307
# ENV NVM_DIR /usr/local/nvm
# ENV NODE_VERSION v22.12.0
# RUN mkdir -p /usr/local/nvm 
# RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
# RUN /bin/bash -c "source $NVM_DIR/nvm.sh && nvm install $NODE_VERSION"
# ENV NODE_PATH $NVM_DIR/versions/node/$NODE_VERSION/bin
# ENV PATH $NODE_PATH:$PATH

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
#------------------
#     Tmux
#------------------

# Version on 22.04 is new enough, no need to compile from source
apt install -y tmux

