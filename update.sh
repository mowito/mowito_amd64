#!/bin/bash

ros_version=$1
if [ $# -eq 0 ]
  then
    echo "defualting the ros version to melodic"
    ros_version=melodic
fi


# create the mwoito dir
CURR_DIR="$(dirname $(realpath $0))"

cd $CURR_DIR
echo "========================="
echo "removing old mowito files"
echo "========================="
./remove_mowito.sh

echo ""
echo "============================"
echo "pulling the the latest stuff"
echo "============================"
echo ""
git pull

echo ""
echo "==========================="
echo "installing the latest stuff"
echo "==========================="
echo ""
sudo dpkg -i debians/*.deb