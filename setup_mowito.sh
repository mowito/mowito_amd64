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
