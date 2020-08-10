#!/bin/bash

ros_version=$1
if [ $# -eq 0 ]
  then
    echo "defualting the ros version to melodic"
    ros_version=melodic
fi


# create the mwoito dir
CURR_DIR="$(dirname $(realpath $0))"

echo "$CURR_DIR"


echo "===================================="
echo "Installing Dependencies"
echo "===================================="


# installing the dependdencies
sudo apt install ros-${ros_version}-voxel-grid -y
sudo apt install ros-${ros_version}-openslam-gmapping -y
sudo apt install ros-${ros_version}-voxel-grid -y
sudo apt install ros-${ros_version}-joint-state-publisher -y
sudo apt install ros-${ros_version}-joint-state-controller -y


echo "===================================="
echo "Installing Mowito packages"
echo "===================================="


sudo dpkg -i $CURR_DIR/debians/ros-${ros_version}-*.deb

# registering the user
echo ""
echo "=============================="
echo "==== ROBOT REGISTRATION ======"
echo "=============================="
source /opt/ros/${ros_version}/setup.bash
rosrun mlicense robot_reg.py

echo "=============================="
echo "===== ROBOT SETUP DONE ======="
echo "=============================="
