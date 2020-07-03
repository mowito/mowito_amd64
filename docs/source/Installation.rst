Setting up  mowito
=======================

User Registration
-------------------

Register yourself on this website https://mowito.in/navigation_stack.html

Installing Mowito on Computer
------------------------------------------

Ubuntu 18 - ROS Melodic
^^^^^^^^^^^^^^^^^^^^^^^^^^^

1. Clone the repo in the home directory, using

``git clone -b melodic https://github.com/mowito/mowito_amd64.git ~/mowito_amd64``\ 

2. Remove any previous installation of Mowito stack 

   ``cd ~/mowito_amd64``\ 

   ``./remove_mowito.sh melodic``

3. Install the new Mowito stack 

 ``./setup_mowito.sh melodic``


Ubuntu 16 - ROS Kinetic
^^^^^^^^^^^^^^^^^^^^^^^^^^^

1. Clone the repo in the home directory, using

``git clone -b kinetic https://github.com/mowito/mowito_amd64.git ~/mowito_amd64	``\ 

2. Remove any previous installation of Mowito stack 

   ``cd ~/mowito_amd64``\ 

   ``./remove_mowito.sh kinetic``

3. Install the new Mowito stack 

 ``./setup_mowito.sh kinetic``

