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
      
      ``cd ~/mowito_ws/src/ && git clone https://github.com/mowito/mowito_husky.git``

      .. NOTE::

            To use velodyne and `slam toolbox <https://github.com/SteveMacenski/slam_toolbox>`_ with husky, switch to the branch **velodyne_with_husky**

                  ``cd ~/mowito_ws/src/mowito_husky && git checkout velodyne_with_husky``

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

                  For using `slam toolbox` for mapping/ SLAM with velodyne, use the following commad:

                        ``roslaunch mowito_husky sim_mw_navigation_with_no_map_slam_toolbox.launch``

                  1.2. **Autonomous goal selection ,through Exploration**:
                  
                        ``roslaunch mowito_husky sim_mw_mapping_with_explore.launch``
      
                  on rviz you can see the robot automatically moving and exploring the area

                  1.3. **Manual navigation**:
                  
                        ``roslaunch mowito_husky sim_mw_mapping.launch``
                  
                  in another terminal, start the remote control:
                  
                        ``rosrun teleop_twist_keyboard teleop_twist_keyboard.py``
                  
                  and use it move the robot around

            2. While moving the robot is simultaneously creating the map too. In order to save the map, on a new terminal exeute the following:
                  - if you were using mw_mapping
         
                        ``cd && rosrun map_server map_saver -f mymap``

                  the map (pgm and yaml) is saved  in the home directory with the name mymap.pgm and mymap.yaml

                  - if you were using cartographer to build the map

                        ``rosrun mowito_husky save_carto_map.sh map_name``
            
                  the map (pbstream) is saved  in the home directory with the name **map_name.pbstream**. If no map_name is given then it would save as **map.pbstream**

                  - if you were using slam toolbox to build the map, open the slam toolbox plugin in Rviz by clicking the panels and give a name for the map and store it using serialize map option.      

.. image:: Images/slam_toolbox/panels.png
  :alt: panels.png
  :align: center
            
.. image:: Images/slam_toolbox/toolbox.png
  :alt: toolbox.png
  :align: center                  
                                    
the map is saved in the .ros folder in the home directory with the name **husky_map.posegraph** and **husky_map.data**. 

Alternatively, in order to save the map, on a new terminal execute the following:
      
      ``rosservice call /slam_toolbox/serialize_map "husky_serialize"``

C. Running Navigation  with a pre-exitsting Map
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
            0. Source the workspace

                  ``source ~/mowito_ws/devel/setup.bash``

            
            1. Now, lets run navigation with map:
                  
                  ``roslaunch mowito_husky sim_mw_navigation.launch``

               If you want to use the map created in the previous section use this

                  ``roslaunch mowito_husky sim_mw_navigation.launch map_name:=mymap``


               For using `cartographer` for mapping/ SLAM instead of default mw_mapping, use the following commad:

                  ``roslaunch mowito_husky sim_mw_navigation.launch cartographer:=true``               
               
               For using `slam toolbox` for mapping/ SLAM with velodyne, use the following commands:
                  - move the map data to `.ros` folder in your system by running the following two commands:
         
                        ``cd ~/mowito_ws/src/mowito_husky/husky/mowito_husky/maps/``
                        ``cp husky_serialize.data husky_serialize.posegraph ~/.ros/``

                  - set the name of the map file and map start pose [x,y,theta] in mowito_ws/src/mowito_husky/husky/mowito_husky/config/slam_toolbox_config/slam_toolbox_localization.yaml:
         
                        ``map_file_name: husky_serialize``
                        
                        ``map_start_pose: [0.0, 0.0, 0.0]``

                  - run `slam toolbox` for mapping/ SLAM with velodyne:

                        ``roslaunch mowito_husky sim_mw_navigation_slam_toolbox.launch``               


            2. In the rviz, click on the second top panel, click on the nav goal option, and click on the displayed map to give goal to the robot

            3. look at the output on the rviz, the path planned and the motion of the robot.