How To Use on ROSbot
=====================================

On all the terminals you open, source the ROS:

For ROS Melodic

   ``source /opt/ros/melodic/setup.bash``

For ROS Kinetic 

   ``source /opt/ros/kinetic/setup.bash``


::

      TIP add the above line to your bashrc, so that it is automatically sourced


For Simulation
--------------

A. Set up turtle bot sim
^^^^^^^^^^^^^^^^^^^^^^^^^
   1. Clone the turtle bot sim in mowito_ws (the one you setup during installation)
      
      ``cd ~/mowito_ws/src/ && git clone ``

   2. Build the workspace 
      ``cd ~/mowito_ws/ && catkin_make``


B. Running Navigation with no Map / Navigation to create Map
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
            1. Create a map using either of these three methods:
                  
                  1.1. **Manual navigation**:
         
                  
                        ``roslaunch mowito_turtlebot sim_mw_mapping.launch``
                  
                  in another terminal, start the remote control:
                  
                        ``rosrun teleop_twist_keyboard teleop_twist_keyboard``
                  
                  and use it move the robot around

                  1.2. **Navigation, by giving goals through the rviz**:
                  
                        ``roslaunch mowito_turtlebot sim_navigation_with_no_map.launch``
                  
                  on rviz, give goals on the map, and the robot will move autnomously while creating the map

                  1.3. **Autonomous goal selection ,throuh Exploration**:
                  
                        ``roslaunch mowito_turtlebot sim_mw_mapping_with_explore.launch``
      
                  on rviz you can see the robot automatically moving and exploring the area

            2. Once you are done creating the map on rviz, save the map 
               on a new terminal exeute the following:
         
                        ``cd && rosrun map_server map_saver -f mymap``
            
               the map (pgm and yaml) is saved  in the home directory with the name mymap.pgm and mymap.yaml

C. Running Navigation  with a pre-exitsting Map
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

            1. Place the robot at the origin of map (the place where you started mapping)
            
            2. Now, for running the entire system with mowito’s controller run
                  
                  ``roslaunch mowito_turtlebot sim_mw_navigation.launch``

            If you want to use the map created in the previous section use this

                  ``roslaunch mowito_turtlebot sim_mw_navigation.launch map_name:=mymap``


            3. In the rviz, click on the second top panel, click on the nav goal option, and click on the displayed map to give goal to the robot

            4. look at the output on the rviz, the path planned and the motion of the robot.

