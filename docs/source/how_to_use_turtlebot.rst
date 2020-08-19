How To Use on Turtle Bot
=====================================

On all the terminals you open, source the ROS:

For ROS Melodic

   ``source /opt/ros/melodic/setup.bash``

For ROS Kinetic 

   ``source /opt/ros/kinetic/setup.bash``


::

      TIP add the above line to your bashrc, so that it is automatically sourced


For Simulation
----------------

A. Set up turtle bot sim
^^^^^^^^^^^^^^^^^^^^^^^^^
   1. Clone the turtle bot sim in mowito_ws (the one you setup during installation)
      
      ``cd ~/mowito_ws/src/ && git clone https://github.com/akshay-antony/turtle_mowito.git  ``

   2. Install the dependencies 
   
      ``cd ~/mowito_ws/ && rosdep install --from-paths src --ignore-src -r -y``

   3. Build the workspace
      
      ``catkin_make``


B. Running Navigation with no Map (SLAM) / Navigation to create Map
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
            0. Start the simulator, on one terminal:

                  ``export TURTLEBOT3_MODEL=waffle_pi`` 

                  ``roslaunch turtlebot3_gazebo turtlebot3_world.launch                   ``

            1. One a new terminal 

                  ``export TURTLEBOT3_MODEL=waffle_pi`` 

               then follow on of the three ways to run the robot without map

                  1.1. **Navigation, by giving goals through the rviz**:
                  
                        ``roslaunch mowito_turtlebot turtle_mowito_nav_no_map.launch``
                  
                  on rviz, give goals on the map, and the robot will move autnomously while creating the map

                  1.2. **Autonomous goal selection ,throuh Exploration**:
                  
                        ``roslaunch mowito_turtlebot turtle_mowito_exploration.launch``
      
                  on rviz you can see the robot automatically moving and exploring the area

                  1.3. **Manual navigation**:
                  
                        ``roslaunch mowito_turtlebot turtle_mowito_mapping.launch``
                  
                  in another terminal, start the remote control:
                  
                        ``rosrun teleop_twist_keyboard teleop_twist_keyboard``
                  
                  and use it move the robot around

            2. While moving the robot is simultaneously creating the map too. In order to save the map, 
               on a new terminal exeute the following:
         
                        ``cd && rosrun map_server map_saver -f mymap``
            
               the map (pgm and yaml) is saved  in the home directory with the name mymap.pgm and mymap.yaml

C. Running Navigation  with a pre-exitsting Map
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
            0. Start the simulator, on one terminal:

                  ``export TURTLEBOT3_MODEL=waffle_pi`` 

                  ``roslaunch turtlebot3_gazebo turtlebot3_world.launch                   ``

            
            1. Now, on the other terminal for running the entire system with mowito’s controller run

                  ``export TURTLEBOT3_MODEL=waffle_pi``
                  
                  ``roslaunch mowito_turtlebot turtle_mowito_nav_map.launch``

            If you want to use the map created in the previous section use this

                  ``roslaunch mowito_turtlebot turtle_mowito_nav_map.launch map_name:=mymap``


            2. In the rviz, click on the second top panel, click on the nav goal option, and click on the displayed map to give goal to the robot

            3. look at the output on the rviz, the path planned and the motion of the robot.