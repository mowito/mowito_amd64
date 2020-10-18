======================
Step 2 : Setup the Bot
======================

This section shall provide the instructions to setup the stack on the chosen Bot.


--------------------
Setup for Simulation
--------------------

There are 3 steps to setup the chosen bot for simulation purposes

Step 1 : Cloning the chosen bot in the mowito_ws (the one you setup during installation)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

**For ROSBot, run the following command**

    ``cd ~/mowito_ws/src/ && git clone https://github.com/mowito/mowito_rosbot.git``


**For TurtleBot, run the following command**

    ``cd ~/mowito_ws/src/ && git clone https://github.com/mowito/mowito_turtlebot.git``

**For HuskyBot, run the following command**

    ``cd ~/mowito_ws/src/ && git clone https://github.com/mowito/mowito_husky.git``

**For JackalBot, run the following command**

    ``cd ~/mowito_ws/src/ && git clone https://github.com/mowito/mowito_jackal.git``

Step 2 : Install the dependencies
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    ``cd ~/mowito_ws/ && rosdep install --from-paths src --ignore-src -r -y``


Step 3 : Build the workspace
^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    ``catkin_make``

------------------
Setup for Hardware
------------------

