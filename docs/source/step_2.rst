======================
Step 2 : Setup the Bot
======================

This section shall provide the instructions to setup the stack on the chosen Bot.


--------------------
Setup for Simulation
--------------------

There are 3 steps to setup the chosen bot for simulation purposes


.. rst-class:: content-collapse

Step 1 : Cloning the chosen bot in the mowito_ws (the one you setup during installation)
===========================================================================================

.. Step 1 : Cloning the chosen bot in the mowito_ws (the one you setup during installation)
.. ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

**For ROSBot, run the following command**

    ``cd ~/mowito_ws/src/ && git clone https://github.com/mowito/mowito_rosbot.git``
    ``cd ~/mowito_ws/src/ && git clone https://github.com/mowito/mw_mprims.git``


**For TurtleBot, run the following command**

    ``cd ~/mowito_ws/src/ && git clone https://github.com/mowito/mowito_turtlebot.git``

**For Husky, run the following command**

    ``cd ~/mowito_ws/src/ && git clone https://github.com/mowito/mowito_husky.git``

    .. NOTE::

            To use velodyne and `slam toolbox <https://github.com/SteveMacenski/slam_toolbox>`_ with husky, switch to the branch **velodyne_with_husky**

                  ``cd ~/mowito_ws/src/mowito_husky && git checkout velodyne_with_husky``

**For JackalBot, run the following command**

    ``cd ~/mowito_ws/src/ && git clone https://github.com/mowito/mowito_jackal.git``

Step 2 : Install the dependencies
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    ``cd ~/mowito_ws/ && rosdep install --from-paths src --ignore-src -r -y``


Step 3 : Build the workspace
^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    ``catkin_make``

Step 4 : FOR TURTLEBOT ONLY
^^^^^^^^^^^^^^^^^^^^^^^^^^^

Run the following commands

    ``source <path_to_mowito_ws>/devel/setup.bash``

    ``export TURTLEBOT3_MODEL=waffle_pi``


