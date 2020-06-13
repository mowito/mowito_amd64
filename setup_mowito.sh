#!/bin/bash

ros_version=$1
if [ $# -eq 0 ]
  then
    echo "defualting the ros version to melodic"
    ros_version=melodic
fi


# create the mwoito dir
BASEDIR="$(dirname $(realpath $0))"

if [ -d "$HOME/mowito" ] 
then
    echo "Directory ~/mowito exists." 
else
    echo "creating ~/mowito directory."
    mkdir ~/mowito
fi
echo "$BASEDIR"
cp -r "$BASEDIR"/. ~/mowito/


echo "===================================="
echo "Installing Mowito packages"
echo "===================================="

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

rm -rf  "$BASEDIR"