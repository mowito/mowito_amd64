How to use
==========
Now, since the SIM is setup, you are ready to try out all the features of Mowito:

Running Navigation with no Map / Navigation to create Map
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
            1. Create a map using either of these three methods:
                  
                  1.1. **Manual navigation**::
                  
                        source ~/mowito_ws/devel/setup.bash
                  
                        roslaunch rosbot_description rosbot_rviz_mapping.launch
                  
                  in another terminal, start the remote control::
                  
                        source ~/mowito_ws/devel/setup.bash
                  
                        rosrun teleop_twist_keyboard teleop_twist_keyboard
                  
                  and use it move the robot around

                  1.2. **Navigation, by giving goals through the rviz**::

                        source ~/mowito_ws/devel/setup.bash
                  
                        roslaunch rosbot_description rosbot_rviz_SLAM_nav.launch
                  
                  on rviz, give goals on the map, and the robot will move autnomously while creating the map

                  1.3. **Autonomous goal selection ,throuh Exploration**::
                  
                        source ~/mowito_ws/devel/setup.bash
                  
                        roslaunch rosbot_description rosbot_rviz_SLAM_explore.launch
      
                  on rviz you can see the robot automatically moving and exploring the area

            2. Once you are done creating the map on rviz, save the map 
               on a new terminal exeute the following::
            
                        source ~/mowito_ws/devel/setup.bash
            
                        cd && rosrun map_server map_saver -f mymap
            
               the map (pgm and yaml) is saved  in the home directory with the name mymap.pgm and mymap.yaml

Running Navigation  with a pre-exitsting Map
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

            1. Place the robot at the origin of map (the place where you started mapping)
            
            2. Now, for running the entire system with mowito’s controller run:: 

                  source ~/mowito_ws/devel/setup.bash
                  
                  roslaunch rosbot_description rosbot_rviz_mwpfl_nav.launch map_name:=mymap

            3. In the rviz, click on the second top panel, click on the nav goal option, and click on the displayed map to give goal to the robot

            4. look at the output on the rviz, the path planned and the motion of the robot.