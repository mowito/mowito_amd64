#!/bin/bash

ros_version=$1

echo "===================================="
echo "Installing Mowito packages"
echo "===================================="

sudo dpkg -i ~/mowito/debians/ros-${ros_version}-*.deb
