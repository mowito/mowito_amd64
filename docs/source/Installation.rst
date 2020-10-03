Setting up  mowito
=======================

User Registration
-------------------

Register yourself on this website https://mowito.in/navigation_stack.html

We need your email to mail you the password, and to count how many people are using Mowito.

We won't spam. :) 

Installing Mowito on Computer
------------------------------------------

Ubuntu 18 - ROS Melodic
^^^^^^^^^^^^^^^^^^^^^^^^^^^
1. Create a ROS workspace directory structure (would be useful in running simulation)
	
	``mkdir -p ~/mowito_ws/src/``\

2. Clone the repo in the workspace you just created, using

	``cd mowito_ws/src/``

	``git clone -b melodic https://github.com/mowito/mowito_amd64.git`` 

3. Remove any previous installation of Mowito stack 

	``cd mowito_amd64``\ 

	``./remove_mowito.sh melodic``

4. Install the new Mowito stack 

 	``./setup_mowito.sh melodic``\

5. [OPTIONAL] If you want to use the Rosbot Simulation, then build the workspace
	
	``source <path to mowito_ws>/devel/setup.bash``\

	``cd ~/mowito_ws && catkin_make``



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
	
	``source <path to mowito_ws>/devel/setup.bash``\
	
	``cd ~/mowito_ws && catkin_make``

