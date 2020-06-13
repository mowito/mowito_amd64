#!/bin/bash

ros_version=$1
if [ $# -eq 0 ]
  then
    echo "defualting the ros version to melodic"
    ros_version=melodic
fi

echo "===================================="
echo "Installing Mowito packages"
echo "===================================="

# get the address of the directory
if [ -d "$HOME/mowito" ] 
then
    echo "Directory ~/mowito exists." 
else
    echo "creating ~/mowito directory."
    mkdir ~/mowito
fi
pwd
cp -r "$PWD"/* ~/mowito/
pwd
# installing the dependdencies
sudo apt install ros-${ros_version}-voxel-grid -y
sudo apt install ros-${ros_version}-openslam-gmapping -y
sudo apt install ros-${ros_version}-voxel-grid -y

sudo dpkg -i ~/mowito/debians/ros-${ros_version}-*.deb

# registering the user
echo ""
echo "=============================="
echo "==== ROBOT REGISTRATION ======"
echo "=============================="
source /opt/ros/${ros_version}/setup.bash
rosrun mlicense robot_reg.py

sudo rmdir "$PWD"