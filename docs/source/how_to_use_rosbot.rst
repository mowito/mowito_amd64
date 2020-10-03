How To Use on ROSbot
=====================================

On all the terminals you open, source the ROS:

For ROS Melodic

   ``source <path to mowito_ws>/devel/setup.bash``

For ROS Kinetic 

   ``source <path to mowito_ws>/devel/setup.bash``


::

      TIP add the above line to your bashrc, so that it is automatically sourced


For Simulation
--------------

The package comes with Husarion's Rosbot Simulator. Here are the steps to use it.


A. Running Navigation with no Map / Navigation to create Map
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
            1. Create a map using either of these three methods:
                  
                  1.1. **Manual navigation**:
         
                  
                        ``roslaunch mowito_rosbot sim_mw_mapping.launch``
                  
                  in another terminal, start the remote control:
                  
                        ``rosrun teleop_twist_keyboard teleop_twist_keyboard``
                  
                  and use it move the robot around

                  1.2. **Navigation, by giving goals through the rviz**:
                  
                        ``roslaunch mowito_rosbot sim_mw_navigation_with_no_map.launch``
                  
                  on rviz, give goals on the map, and the robot will move autnomously while creating the map

                  1.3. **Autonomous goal selection ,throuh Exploration**:
                  
                        ``roslaunch mowito_rosbot sim_mw_mapping_with_explore.launch``
      
                  on rviz you can see the robot automatically moving and exploring the area

            2. Once you are done creating the map on rviz, save the map 
               on a new terminal exeute the following:
         
                        ``cd && rosrun map_server map_saver -f mymap``
            
               the map (pgm and yaml) is saved  in the home directory with the name mymap.pgm and mymap.yaml

B. Running Navigation  with a pre-exitsting Map
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

            1. Place the robot at the origin of map (the place where you started mapping)
            
            2. Now, for running the entire system with mowito’s controller run
                  
                  ``roslaunch mowito_rosbot sim_mw_navigation.launch``

            If you want to use the map created in the previous section use this

                  ``roslaunch mowito_rosbot sim_mw_navigation.launch map_name:=mymap``


            3. In the rviz, click on the second top panel, click on the nav goal option, and click on the displayed map to give goal to the robot

            4. look at the output on the rviz, the path planned and the motion of the robot.



On Real ROSbot Robot
--------------------------

A. Running Navigation with no Map / Navigation to create Map
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

            1. create a map using either of these three methods:

                  1.1. **manual navigation**\  

                        ``roslaunch mowito_rosbot run_mw_mapping.launch``\  
                     
                     in another terminal, start the remote control
                         
                        ``rosrun teleop_twist_keyboard teleop_twist_keyboard``\  
                        
                     and use it move the robot around 


                  1.2. **Navigation, by giving goals through the rviz**\  
                     
                        ``roslaunch mowito_rosbot run_navigation_with_no_map.launch``\  

                     in another terminal start rviz 
                     
                        ``roslaunch ~/mowito/launch/start_rviz.launch``\  

                     on rviz, give goals on the map, and the robot will move autnomously while creating the map 


                  1.3. **Autonomous goal selection ,throuh Exploration**\ 
                     
                        ``roslaunch mowito_rosbot run_mw_mapping_with_explore.launch``\  

                     in another terminal start rviz 
                     
                        ``roslaunch mowito_rosbot start_rviz.launch``\  
                        
                     on rviz you can see the robot automatically moving and exploring the area

            2. Once you are done creating the map on rviz, save the map on a new terminal exeute the following
               
                  ``cd && rosrun map_server map_saver -f mymap``\  

               the map (pgm and yaml) is saved in the home directory with the name mymap.pgm andmymap.yaml


B. Running Navigation with a pre-exitsting Map
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

            1. Place the robot at the origin of map (the place where you started
               mapping)

            2. Now, for running the entire system with mowito’s controller run
               
                  
                  ``roslaunch mowito_rosbot run_mw_navigation.launch map_name:=mymap``\ 

            3. in another terminal start rviz

               
                  ``roslaunch mowito_rosbot start_rviz.launch``\ 

            4. in the rviz, click on the second top panel, click on the nav goal
               option, and click on the displayed map to give goal to the robot

            5. look at the output on the rviz, the path planned and the motion of
               the robot.


           
