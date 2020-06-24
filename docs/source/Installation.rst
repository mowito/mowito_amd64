
Installation
============

    1.Pre-requisite: install ROS 1 (kinetic or later) based on your ubuntu version.

      Prepare the repository::

            cd ~
            mkdir -p mowito_ws/src
            cd ~/mowito_ws/src
            catkin_init_workspace
            cd ~/mowito_ws
            catkin_make

      Above commands should execute without any warnings or errors.


    2.Clone this repository to your workspace::

            cd ~/mowito_ws/src
            git clone https://gitlab.com/mowito_release/mowito_sim.git

    3.Install depencencies::

            cd ~/mowito_ws
            rosdep install --from-paths src --ignore-src -r -y

    4.Build the workspace::

            cd ~/mowito_ws
            catkin_make

      From this moment you can use rosbot simulations. Please remember that each time, when you open new terminal window, you will need to load system variables::

            source ~/mowito_ws/devel/setup.sh