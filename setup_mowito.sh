#!/bin/bash

ros_version=$1
skip_dependencies=$2

if [ $# -eq 0 ]
  then
    echo "defualting the ros version to melodic"
    ros_version=melodic
fi

#optional arguement to skip installing dependencies
if [ -z $2 ]
  then
    skip_dependencies=False
else
	skip_dependencies=True
fi

# create the mwoito dir
CURR_DIR="$(dirname $(realpath $0))"

echo "$CURR_DIR"

arch_version="${CURR_DIR: -5}"

#install dependencies and mowito packages
python3 ${CURR_DIR}/install_scripts/install_mowito.py ${ros_version} ${arch_version} ${skip_dependencies}

if [ $? -ne 1 ]
then
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
fi
