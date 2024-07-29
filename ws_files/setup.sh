#!/bin/bash
set -e

USERNAME=devuser
WORKSPACE=ros2_ws

# Change to the workspace directory
cd /home/${USERNAME}/${WORKSPACE}

# Ensure the workspace directory has the correct ownership and permissions
sudo chown -R ${USERNAME}:${USERNAME} ws_files
sudo chmod -R u+rwx ws_files

# Import repositories
vcs import < ws_files/ros2.repos ws_files

# Update package lists and install dependencies
sudo apt-get update
rosdep update --rosdistro=$ROS_DISTRO
rosdep install --from-paths src --ignore-src -y --rosdistro=$ROS_DISTRO
