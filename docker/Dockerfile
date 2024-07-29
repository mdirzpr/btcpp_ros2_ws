# Dockerfile for ROS2-jazzy

FROM ros:jazzy-ros-base AS ros2_jazzy_ws

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Set environment variables
ENV ROS_DISTRO=jazzy
ENV AMENT_PREFIX_PATH=/opt/ros/${ROS_DISTRO}
ENV COLCON_PREFIX_PATH=/opt/ros/${ROS_DISTRO}
ENV LD_LIBRARY_PATH=/opt/ros/${ROS_DISTRO}/lib
ENV PATH=/opt/ros/${ROS_DISTRO}/bin:$PATH
ENV PYTHONPATH=/opt/ros/${ROS_DISTRO}/local/lib/python3.10/dist-packages:/opt/ros/${ROS_DISTRO}/lib/python3.10/site-packages
ENV ROS_PYTHON_VERSION=3
ENV ROS_VERSION=2
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y \
    git \
    cmake \
    build-essential \
    libzmq3-dev \
    libboost-dev \
    libsqlite3-dev \
    libgtest-dev \
    apt-utils \
    bash \
    coreutils \
    findutils \
    bash-completion \
    gdb \
    python3-pip \
    python3-tk \
    python3-vcstool \
    libegl1 \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    '^libxcb.*-dev' \
    libx11-xcb-dev \
    libxi-dev \
    libxkbcommon-dev \
    libxkbcommon-x11-dev \
    libxrender-dev \
    openssh-client \
    python3-argcomplete \
    ros-dev-tools \
    ros-${ROS_DISTRO}-ament-cmake \
    ros-${ROS_DISTRO}-demo-nodes-cpp \
    python3-colcon-common-extensions \
    vim \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Initialize and update rosdep
RUN rosdep init || echo "rosdep already initialized" && \
    rosdep update

# Define the arguments
ARG USERNAME=devuser
ARG WORKSPACE=ros2_ws

# Create a user and switch to it
RUN useradd -ms /bin/bash ${USERNAME} && \
    echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Create a ROS 2 workspace and set permissions
RUN mkdir -p /home/${USERNAME}/${WORKSPACE}/src && \
    chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}

# Copy src and ws_files to the container
COPY src /home/${USERNAME}/${WORKSPACE}/src
COPY ws_files /home/${USERNAME}/${WORKSPACE}/ws_files

# Switch to the new user
USER ${USERNAME}
WORKDIR /home/${USERNAME}/${WORKSPACE}

# Source ROS 2 setup script
RUN echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> ~/.bashrc

# Set up ROS 2 and autocompletion
RUN echo "if [ -f /usr/share/colcon_cd/function/colcon_cd-argcomplete.bash ]; then source /usr/share/colcon_cd/function/colcon_cd-argcomplete.bash; fi" >> ~/.bashrc

# Default command
CMD ["/bin/bash"]
