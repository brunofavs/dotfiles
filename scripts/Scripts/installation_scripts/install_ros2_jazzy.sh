#!/usr/bin/env bash
set -euo pipefail

#  Script should be executed with sudo
# https://docs.ros.org/en/jazzy/Installation/Ubuntu-Install-Debs.html

apt install -y software-properties-common
add-apt-repository universe

apt update && apt install curl -y

export ROS_APT_SOURCE_VERSION=$(curl -s https://api.github.com/repos/ros-infrastructure/ros-apt-source/releases/latest | grep -F "tag_name" | awk -F'"' '{print $4}')

curl -L -o /tmp/ros2-apt-source.deb "https://github.com/ros-infrastructure/ros-apt-source/releases/download/${ROS_APT_SOURCE_VERSION}/ros2-apt-source_${ROS_APT_SOURCE_VERSION}.$(. /etc/os-release && echo ${UBUNTU_CODENAME:-${VERSION_CODENAME}})_all.deb"

dpkg -i /tmp/ros2-apt-source.deb

###

apt update && apt install -y ros-dev-tools

apt update  && apt upgrade -y

apt install -y ros-jazzy-desktop

apt install -y '~nros-jazzy-rqt*'

# Themes
#
add-apt-repository ppa:papirus/papirus

apt update

apt install qt5-style-kvantum qt6-style-kvantum
