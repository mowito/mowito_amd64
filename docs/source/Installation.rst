=======================
Installation Guide
=======================

-------------------
System Requirements
-------------------

Hardware Requirements
^^^^^^^^^^^^^^^^^^^^^

**Processor :** 

	Intel core i5 or higher (minimum 4 cores) 

	ARM v7/v8 (minimum 4 cores)

**Memory :**

	Minimum     : 4GB RAM

	Recommended : 8GB RAM

**Network :**

	WiFi 2.4/5 GHz

**Sensors(Only when running on Bot Hardware) :**

	1. 2D/3D LiDAR

		a) For SLAM and obstacle avoidance : 30m (wh) minimum range  
		b) For Obstacle Avoidance          : 10m (wh) minimum range

	2. Wheel encoder : 1000 pulse/rotation (minimum)

	3. IMU : MPU 9250, Xsense MTi-3 AHRS, Bosch BNO055

	4. GPS (When operating outdoors)

Software Requirements
^^^^^^^^^^^^^^^^^^^^^

**Operating System**

	Ubuntu 16.04 or higher

**Mandatory tools**

	Robot Operating System (ROS) Kinetic or Melodic


----------------------------------------------
Setting up Mowito Navigation Stack on Computer
----------------------------------------------

User Registration
^^^^^^^^^^^^^^^^^

Register yourself on this website https://mowito.in/navigation_stack.html

We need your email to mail you the password, and to count how many people are using Mowito.

We won't spam. :) 

Ubuntu 18 - ROS Melodic
^^^^^^^^^^^^^^^^^^^^^^^^^^^
1. Create a ROS workspace directory structure (would be useful in running simulation)
	
	``mkdir -p ~/mowito_ws/src/``\

2. Clone the repo in the workspace you just created, using

	``cd ~mowito_ws/src/``

	``git clone -b melodic https://github.com/mowito/mowito_amd64.git`` 

3. Remove any previous installation of Mowito stack 

	``cd mowito_amd64``\ 

	``./remove_mowito.sh melodic``

4. Install the new Mowito stack 

 	``./setup_mowito.sh melodic``\

5. [OPTIONAL] If you want to use the Rosbot Simulation, then build the workspace
	
	``cd ~/mowito_ws && catkin_make``\
	
	``source <path to mowito_ws>/devel/setup.bash``	

Ubuntu 16 - ROS Kinetic
^^^^^^^^^^^^^^^^^^^^^^^^^^^
1. Create a ROS workspace directory structure (would be useful in running simulation)

	``mkdir -p ~/mowito_ws/src/``

2. Clone the repo in the workspace you just created, using

	``cd mowito_ws/src/``\

	``git clone -b kinetic https://github.com/mowito/mowito_amd64.git``\ 

3. Remove any previous installation of Mowito stack 

	``cd ~/mowito_amd64``\ 

	``./remove_mowito.sh kinetic``

4. Install the new Mowito stack 

	``./setup_mowito.sh kinetic``\

5. [OPTIONAL] If you want to use the Rosbot Simulation, then build the workspace
	
	``cd ~/mowito_ws && catkin_make``\

	``source <path to mowito_ws>/devel/setup.bash``


