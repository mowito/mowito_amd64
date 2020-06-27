Running the Mowito's Navigation Stack
=====================================

For Simulation
--------------

For Simulation, check ~/mowito/launch/simulation for the required launch
files. The procedures and names are similar to the launch files for
running on the real robot (mentioned below).

On Real Robot
-------------

A. Running Navigation with no Map / Navigation to create Map
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1. create a map using either of these three methods: 
1.1. **manual
   navigation**\  ``source /opt/ros/melodic/setup.bash``\ 
   ``roslaunch ~/mowito/launch/run_mw_mapping.launch``\  in another
   terminal, start the remote control
   ``rosrun teleop_twist_keyboard teleop_twist_keyboard``\  and use it
   move the robot around 
1.2. **Navigation, by giving goals through the
   rviz**\  ``source /opt/ros/melodic/setup.bash``\ 
   ``roslaunch ~/mowito/launch/run_navigation_with_no_map.launch``\  in
   another terminal start rviz ``source /opt/ros/melodic/setup.bash``\ 
   ``roslaunch ~/mowito/launch/start_rviz.launch``\  on rviz, give goals
   on the map, and the robot will move autnomously while creating the
   map 
1.3. **Autonomous goal selection ,throuh Exploration**\ 
   ``source /opt/ros/melodic/setup.bash``\ 
   ``roslaunch ~/mowito/launch/run_mw_mapping_with_explore.launch``\  in
   another terminal start rviz ``source /opt/ros/melodic/setup.bash``\ 
   ``roslaunch ~/mowito/launch/start_rviz.launch``\  on rviz you can see
   the robot automatically moving and exploring the area

2. Once you are done creating the map on rviz, save the map on a new
   terminal exeute the following
   ``source /opt/ros/melodic/setup.bash``\ 
   ``cd && rosrun map_server map_saver -f mymap``\  the map (pgm and
   yaml) is saved in the home directory with the name mymap.pgm and
   mymap.yaml

B. Running Navigation with a pre-exitsting Map
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1. Place the robot at the origin of map (the place where you started
   mapping)

2. | Now, for running the entire system with mowito’s controller run
   | ``source /opt/ros/melodic/setup.bash``\ 
   ``roslaunch ~/mowito/launch/run_mw_navigation.launch map_name:=mymap``\ 

3. in another terminal start rviz
   ``source /opt/ros/melodic/setup.bash``\ 
   ``roslaunch ~/mowito/launch/start_rviz.launch``\ 

4. in the rviz, click on the second top panel, click on the nav goal
   option, and click on the displayed map to give goal to the robot

5. look at the output on the rviz, the path planned and the motion of
   the robot.


