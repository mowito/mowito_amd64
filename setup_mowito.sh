#!/bin/bash

ros_version=$1
if [ $# -eq 0 ]
  then
    echo "defualting the ros version to melodic"
    ros_version=melodic
fi


# create the mwoito dir
CURR_DIR="$(dirname $(realpath $0))"

if [ -d "$HOME/mowito" ] 
then
    echo "Directory ~/mowito exists." 
else
    echo "creating ~/mowito directory."
    mkdir ~/mowito
fi

FINAL_DIR=$HOME/mowito
echo "$CURR_DIR"
echo "$FINAL_DIR"

if [ $FINAL_DIR = $CURR_DIR ]
then 
    echo "Already were in Mowito directory"
else 
    echo "Copying the data from $CURR_DIR to $FINAL_DIR"
    cp -r "$CURR_DIR"/. "$FINAL_DIR"
fi

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


if [ $FINAL_DIR = $CURR_DIR ]
then 
    echo "Already were in Mowito directory"
elif [ $CURR_DIR = $HOME ]
then
    echo "$CURR_DIR is the home directory"
else 
    echo "deleting the old directory of $CURR_DIR"
    sudo rm -r  "$CURR_DIR"
fi