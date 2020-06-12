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
BASEDIR=$(dirname "$0")
# echo "$BASEDIR"

sudo dpkg -i $BASEDIR/debians/ros-${ros_version}-*.deb

# registering the user
echo ""
echo "=============================="
echo "==== ROBOT REGISTRATION ======"
echo "=============================="
source /opt/ros/${ros_version}/setup.bash
rosrun mlicense robot_reg.py

