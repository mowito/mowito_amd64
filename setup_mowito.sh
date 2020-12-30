#!/bin/bash

ros_version=$1
arch_version=$2
skip_dependencies=$3

if [ "$1" == "-h" ]; then
  echo "Usage: setup_mowito.sh"
  echo "Usage: setup_mowito.sh [-h]"
  echo "Usage: setup_mowito.sh [rosversion]"
  echo "Usage: setup_mowito.sh [rosversion] [arch-version]"
  echo "Usage: setup_mowito.sh [rosversion] [arch-version] skip-depends"
  echo "Positional arguements"
  echo "	-h           : Help, display usage"
  echo "	rosversion   : Version of ROS installed(noetic/melodic)"
  echo "		       Defaults to melodic if not specified"
  echo "	arch-version : Archtecture to be installed (amd64/arm64)"
  echo "		       Defaults to amd64 if not specified"
  echo "	skip-depends : Skip installing dependencies (optional)"
  echo "	               Installs dependencies if not specified"
  exit 0
fi


if [ $# -eq 0 ]
  then
    echo "defaulting the ros version to melodic and arch to amd64"
    ros_version=melodic
    arch_version=amd64
fi

if [ $# -eq 1 ]
  then
    echo "defaulting arch to amd64"
    arch_version=amd64
fi

#optional arguement to skip installing dependencies
if [ -z $3 ]
  then
    skip_dependencies=False
else
	skip_dependencies=True
fi

# create the mwoito dir
CURR_DIR="$(dirname $(realpath $0))"

echo "$CURR_DIR"

sudo echo ""

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
