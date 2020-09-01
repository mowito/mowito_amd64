How To Use on Husky
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

A. Set up Husky sim
^^^^^^^^^^^^^^^^^^^^^^^^^
   1. Clone the Husky sim in mowito_ws (the one you setup during installation)
      
      ``cd ~/mowito_ws/src/ && git clone https://github.com/akshay-antony/mowito_husky.git``

   2. Install the dependencies 
   
      ``cd ~/mowito_ws/ && rosdep install --from-paths src --ignore-src -r -y``

   3. Build the workspace
      
      ``catkin_make``


B. Running Navigation with no Map (SLAM) / Navigation to create Map
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
            0. Source the workspace

                  ``source ~/mowito_ws/devel/setup.bash``\

            1. Now use one of the three ways to run the robot without map


                  1.1. **Navigation, by giving goals through the rviz**:
                  
                        ``roslaunch mowito_husky sim_mw_navigation_with_no_map.launch``
                  
                  on rviz, give goals on the map, and the robot will move autnomously while creating the map. 
                  For using `cartographer` for mapping/ SLAM instead of default mw_mapping, use the following commad:

                        ``roslaunch mowito_husky sim_mw_navigation_with_no_map.launch cartographer:=true``

                  1.2. **Autonomous goal selection ,through Exploration**:
                  
                        ``roslaunch mowito_husky sim_mw_mapping_with_explore.launch``
      
                  on rviz you can see the robot automatically moving and exploring the area

                  1.3. **Manual navigation**:
                  
                        ``roslaunch mowito_husky sim_mw_mapping.launch``
                  
                  in another terminal, start the remote control:
                  
                        ``rosrun teleop_twist_keyboard teleop_twist_keyboard.py``
                  
                  and use it move the robot around

            2. While moving the robot is simultaneously creating the map too. In order to save the map, on a new terminal exeute the following:
         
                        ``cd && rosrun map_server map_saver -f mymap``
            
               the map (pgm and yaml) is saved  in the home directory with the name mymap.pgm and mymap.yaml

C. Running Navigation  with a pre-exitsting Map
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
            0. Source the workspace

                  ``source ~/mowito_ws/devel/setup.bash``

            
            1. Now, lets run navigation with map:
                  
                  ``roslaunch mowito_husky sim_mw_navigation.launch``

               If you want to use the map created in the previous section use this

                  ``roslaunch mowito_husky sim_mw_navigation.launch map_name:=mymap``


            2. In the rviz, click on the second top panel, click on the nav goal option, and click on the displayed map to give goal to the robot

            3. look at the output on the rviz, the path planned and the motion of the robot.