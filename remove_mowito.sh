#!/bin/bash


ros_version=$1
if [ $# -eq 0 ]
  then
    echo "defualting the ros version to melodic"
    ros_version=melodic
fi

echo "===================================="
echo "Cleaning existing Mowito installs"
echo "===================================="

pkg_names=(
    mlicense
    mw-core
    mw-msgs
    mwpfl
    timed-roslaunch
    utils
    mw-mapping
    chief-executive
    mw-costmap
    diagnostic
    roboview
    executive
    task-executive
    controller-executive
    recovery-executive
    global-planner
)


for pkg_name in "${pkg_names[@]}"
do
    printf "\n"
    echo "===================================="
    echo "removing ${pkg_name}"
    echo "===================================="
    printf "\n"
    sudo apt remove ros-${ros_version}-${pkg_name} -y
done
