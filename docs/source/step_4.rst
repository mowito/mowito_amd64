================================
Part 4 : Navigate the Chosen Bot
================================

This section shall provide instructions on how to navigate the chosen Bot.


---------------------------------
Navigation for Simulation Purpose
---------------------------------

**Step 0 : Source the workspace**

    ``source <path_to_mowito_ws>/devel/setup.bash``

**Step 1 : Place the robot at the origin of map (the place where you started mapping)**

**Step 2 : For running the entire system with mowito’s controller, run the following command**

*For ROSBot, run the following command*

    ``roslaunch mowito_rosbot sim_mw_navigation.launch``

    If you want to use the map created in the previous section use the following command
 
    ``roslaunch mowito_rosbot sim_mw_navigation.launch map_name:=mymap``

*For TurtleBot, run the following command*

    ``roslaunch turtlebot3_gazebo turtlebot3_world.launch``

    In another terminal, run the following commands:

    ``export TURTLEBOT3_MODEL=waffle_pi``

    ``roslaunch mowito_turtlebot turtle_mowito_nav_map.launch``
    
    If you want to use the map created in the previous section use the following command
 
    ``roslaunch mowito_turtlebot turtle_mowito_nav_map.launch map_name:=mymap``

*For HuskyBot, run the following command*

    ``roslaunch mowito_husky sim_mw_navigation.launch``
    
    If you want to use the map created in the previous section use the following command
    
    ``roslaunch mowito_husky sim_mw_navigation.launch map_name:=mymap``

    For using cartographer for mapping/ SLAM instead of default mw_mapping, use the following command:

    ``roslaunch mowito_husky sim_mw_navigation.launch cartographer:=true``

    For using slam toolbox for mapping/ SLAM with velodyne, use the following commands:

    1. move the map data to .ros folder in your system by running the following two commands:

       ``cd <path_to_mowito_ws>/src/mowito_husky/husky/mowito_husky/maps/``

       ``cp husky_serialize.data husky_serialize.posegraph ~/.ros/``
    2. set the name of the map file and map start pose [x,y,theta] in mowito_ws/src/mowito_husky/husky/mowito_husky/config/slam_toolbox_config/slam_toolbox_localization.yaml:

       ``map_file_name: husky_serialize``

       ``map_start_pose: [0.0, 0.0, 0.0]``
    
    3. run slam toolbox for mapping/ SLAM with velodyne:
    
       ``roslaunch mowito_husky sim_mw_navigation_slam_toolbox.launch``

*For Jackal, run the following command*

    ``roslaunch mowito_jackal jackal_mw_nav.launch``

Here, "mymap" is the map that was generated in the earlier step (Step 3 : Generate the map)

**Step 3 : in the rviz, click on the second top panel, click on the nav goal option, and click on the displayed map to give goal to the robot**

**Step 4 : look at the output on the rviz, the path planned and the motion of the robot**


----------------------
Route Based Navigation  
----------------------

Overview
^^^^^^^^^^^^^^^^^^^^^^^^^
	- In addition to the waypoint navigation feature in simulation, one can also simulate the robot by giving route points via route.yaml (type) file. 
	- This feature provides user the ability to give pre-planned goals.
	- There are two ways for using this feature. We will be using the example of husky robot simulation to explain this:

.. NOTE::

      While using this feature, it is highly recommended that one uses the **genroute** planner for optimal results. 
 
There are two ways to go about using Routes, based on when the user wants to change the planner types.

**A. Selecting the type of (Global) Planner  before launching the stack**

   1. Open the mission_executive_params.yaml file located inside the `mowito_husky/husky/mowito_husky/config/mission_executive_config` folder of the mowito_husky package.

   2. Change the planner tag to ``genroute``.

   3. Now, lets run navigation with map:

    *For ROSBot run the following command*

      ``roslaunch mowito_rosbot sim_mw_navigation.launch``

    *For TurtleBot run the following commands*
          
      ``roslaunch turtlebot3_gazebo turtlebot3_world.launch``

      In another terminal, run the following commands:

      ``export TURTLEBOT3_MODEL=waffle_pi``

      ``roslaunch mowito_turtlebot turtle_mowito_nav_map.launch``

    *For Husky run the following command*
          
      ``roslaunch mowito_husky sim_mw_navigation.launch``

    *For Jackal run the following command*
          
      ``roslaunch mowito_jackal jackal_mw_nav.launch``  

   4. In a new terminal, run the set_route_client node with the appropriate file path to the route.yaml (type) file. Sample route files are available in the samples folder of the mowito_husky package:
                  
      ``rosrun executive set_route_client path/to/route/file``     

   
**B. Changing the (Global) Planner during the run (after launching the stack)**

   1. Lets run navigation with map:
      
      *For ROSBot run the following command*

        ``roslaunch mowito_rosbot sim_mw_navigation.launch``

      *For TurtleBot run the following command*

       ``roslaunch turtlebot3_gazebo turtlebot3_world.launch``

       In another terminal, run the following commands:

       ``export TURTLEBOT3_MODEL=waffle_pi``

       ``roslaunch mowito_turtlebot turtle_mowito_nav_map.launch``   

      *For Husky run the following command*
          
        ``roslaunch mowito_husky sim_mw_navigation.launch``
      
      *For Jackal run the following command*
          
         ``roslaunch mowito_jackal jackal_mw_nav.launch``

   2. Use the change_planner and change_controller services to change the planner and controller respectively. For this, in a new terminal, execute:  
   
      ``rosservice call /mission_executive/change_planner genroute``

   4. Now, in a new terminal, run the set_route_client node with the appropriate file path to the route.yaml (type) file. Sample route files are available in the samples folder of the mowito_husky package:
                  
      ``rosrun executive set_route_client path/to/route/file``


.. image:: Images/route_based_navigation/set_route.png
  :alt: set_route.png

*Example: rosbot following a given route*