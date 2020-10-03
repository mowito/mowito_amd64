#!/bin/bash

ros_version=$1
if [ $# -eq 0 ]
  then
    echo "defualting the ros version to kinetic"
    ros_version=kinetic
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

sudo apt-get install ros-${ros_version}-behaviortree-cpp-v3 -y           # installation of behavior tree
sudo apt-get install ros-${ros_version}-teleop-twist-keyboard -y         # installation of teleop-keyboard

sudo apt-get install ros-${ros_version}-map-server -y                    # installation of map-server                     

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
