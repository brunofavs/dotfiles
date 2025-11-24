#!/usr/bin/env bash
set -euo pipefail

#  Script should be executed with sudo
#
# apt install pyenv
# curl -fsSL https://pyenv.run | bash
git clone https://github.com/pyenv/pyenv.git /usr/bin/pyenv

mv /usr/bin/pyenv /usr/bin/pyenv_dir
ln -s /usr/bin/pyenv_dir/bin/pyenv /usr/bin/pyenv

# Pyenv Dependencies https://github.com/pyenv/pyenv/wiki#suggested-build-environment
apt update && apt install -y make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev curl git \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv

source "${HOME}"/.zshrc

pyenv install 3.11.14
pyenv virtualenv 3.11.14 isaac_env

pyenv activate isaac_env

pip install --upgrade pip

pip install "isaacsim[all,extscache]==5.1.0" --extra-index-url https://pypi.nvidia.com

cd ${HOME}\Projects\isaac_lab

