#!/bin/bash
set -e

USERNAME=devuser
WORKSPACE=ros2_ws

# Change to the workspace directory
cd /home/${USERNAME}/${WORKSPACE}

# Ensure the workspace directory has the correct ownership and permissions
sudo chown -R ${USERNAME}:${USERNAME} src
sudo chmod -R u+rwx src

# Import repositories
vcs import < src/ros2.repos src

# Update package lists and install dependencies
sudo apt-get update
rosdep update --rosdistro=$ROS_DISTRO
rosdep install --from-paths src --ignore-src -y --rosdistro=$ROS_DISTRO
