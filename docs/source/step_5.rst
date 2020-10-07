==============================
Step 5 : Tuning Bot Parameters
==============================

This section shall provide a guide to tune the navigation and control functionality of the chosen bot.

Controller: Trajectory Planner Tuning Guide
-------------------------------------------

Overview
^^^^^^^^
Trajectory Planner is a package that is used to drive the robot. It issues the linear and angular velocity commands that are needed to reach the goal. Trajectory Planner in itself does not map a path to the goal; it focuses on following the global path to the goal efficiently.

For a more relatable example, think about how GPS apps map out a path to a destination from a start location, It is up to the driver of the vehicle to follow the path while avoiding other cars, obstacles, speeding up, stopping at traffic lights, etc. Trajectory planner is meant to replicate the 'driver' and choose the best course of action to follow the path to the destination.


Working and Description
^^^^^^^^^^^^^^^^^^^^^^^
Think about how a driver of a vehicle makes simple decisions while following the route given by a GPS app. The driver may choose to accelerate the vehicle or slow it down or turn the steering left or right to add curvature to the vehicle's path. It is reasonable to say that the driver is subconsciously thinking about each combination of the accelerator pedal and the steering wheel and choosing the best of these combinations. Which combination is the best depends on answering questions such as:

  - Does this combination allow me to reach the goal quickly?
  - Am I running into obstacles if choose this combination?
  - Will I stay on the course described by the GPS?

He or she evaluates each combination and chooses the optimal one. This process repeats until the driver reaches the goal.

Trajectory Planner tries to replicate this approach. It takes a set of linear velocities and angular velocities. It then checks the validity of each combination of the two velocities and discards it if invalid. For example, a combination can be invalid if it causes the robot to hit an obstacle.

If the combination is not invalid, a 'score' is assigned to it on the basis of several parameters. The scoring process is analogous to the driver of the vehicle choosing the best course of action in the scenario given before. The scoring parameters include, but are not limited to:

  - Proximity to obstacles
  - Proximity to the goal
  - Proximity to the global path
  - Speed

Tweaking these scoring parameters effectively allows for better navigation and is critical to the Trajectory Planner algorithm.


Robot Parameter Description
---------------------------

We previously saw that tuning the trajectory planner's scoring parameters is important for properly following a path and avoiding obstacles. Before going into the scoring parameters, it is important to let Trajectory Planner know about your robot. Just like the driver knows about his or her vehicle, its acceleration potential, turning radius, braking distance, etc, Trajectory planner also needs to know this information about the robot.

**1. Robot Configuration Parameters**

+------------------------+------------+--------------------------------------------------------------------------------------+
| Parameter              | Units      | Description                                                                          |
+========================+============+======================================================================================+
| max_vel_x              | S.I        | Maximum possible Linear Velocity                                                     |
+------------------------+------------+--------------------------------------------------------------------------------------+
| min_vel_x              | S.I        | Minimum possible Linear Velocity                                                     |
+------------------------+------------+--------------------------------------------------------------------------------------+
| max_vel_theta          | S.I        | Maximum possible Angular Velocity                                                    |
+------------------------+------------+--------------------------------------------------------------------------------------+
| min_vel_theta          | S.I        | Minimum possible Angular Velocity                                                    |
+------------------------+------------+--------------------------------------------------------------------------------------+
| min_in_place_vel_theta | S.I        | Minimum possible Angular Velocity when the robot is turning about its axis and not   |
|                        |            | in linear motion.                                                                    |
+------------------------+------------+--------------------------------------------------------------------------------------+
| acc_lim_x              | S.I        | Maximum possible Linear Acceleration                                                 |
+------------------------+------------+--------------------------------------------------------------------------------------+
| acc_lim_y              | S.I        | Maximum possible Linear Acceleration along y axis (consider positive x-axis to be    |
|                        |            | forward for the robot. Usually this value is set to 0).                              |
+------------------------+------------+--------------------------------------------------------------------------------------+
| acc_lim_theta          | S.I        | Maximum possible Angular Acceleration                                                |
+------------------------+------------+--------------------------------------------------------------------------------------+

**2. Goal Tolerance Parameters**


+------------------------+------------+--------------------------------------------------------------------------------------+
| Parameter              | Units      | Description                                                                          |
+========================+============+======================================================================================+
| xy_goal_tolerance      | S.I        | Maximum allowable deviation in robot position from the goal position.                |
+------------------------+------------+--------------------------------------------------------------------------------------+
| yaw_goal_tolerance     | S.I        | The goal also specifies the direction in which the robot faces at goal-position.     |
|                        |            | This parameter specifies the maximum allowable angular deviation in the robot        |
|                        |            | orientation from the goal orientation.                                               |
+------------------------+------------+--------------------------------------------------------------------------------------+

**3. Differential-Drive Robot Configuration**


+------------------------+------------+--------------------------------------------------------------------------------------+
| Parameter              | Values     | Description                                                                          |
+========================+============+======================================================================================+
| holonomic_robot        | true/false | If robot uses differential drive or cannot move along y-axis, set this to false.     |
|                        |            | If robot can also move in y-direction without turning (eg mecanum wheels),           |
|                        |            | set this to true.                                                                    |
+------------------------+------------+--------------------------------------------------------------------------------------+

**4. Forward Simulation Parameters**


These parameters affect how linear velocity and angular velocity pairs, also called (v, w) pairs, are created or declared invalid.

+------------------------+------------+--------------------------------------------------------------------------------------+
| Parameter              | Units      | Description                                                                          |
+========================+============+======================================================================================+
| sim_time               | seconds    | A small simulation is run with the (v, w) pair. If the robot collides with an        |
|                        |            | obstacle for the given v and w, the pair is declared invalid. sim_time controls how  |
|                        |            | long this simulation runs for.                                                       |
+------------------------+------------+--------------------------------------------------------------------------------------+
| vx_samples             | Number     | Number of samples to take for linear velocity                                        |
+------------------------+------------+--------------------------------------------------------------------------------------+
| vtheta_samples         | Number     | Number of samples to take for angular velocity                                       |
+------------------------+------------+--------------------------------------------------------------------------------------+
| sim_granularity        | Number     | Granularity defines the step size between points on a trajectory. Each point is      |
|                        |            | checked for collision, so lower granularity means testing more points and using more |
|                        |            | computation resources.                                                               |
+------------------------+------------+--------------------------------------------------------------------------------------+
| angular_sim_granularity| Number     | Granularity for angles. Used for orientation instead of position.                    |
+------------------------+------------+--------------------------------------------------------------------------------------+
| heading_lookahead      | Number     | Lookahead for the sim                                                                |
+------------------------+------------+--------------------------------------------------------------------------------------+

**5. Robot Footprint**


+-----------------+------------------------------------------------------------------------------------+--------------------------------------------------------+
| Parameter       | Values                                                                             | Description                                            |
+=================+====================================================================================+========================================================+
| type            |  "circular", "polygon"                                                             | Type of robot.                                         |
+-----------------+------------------------------------------------------------------------------------+--------------------------------------------------------+
| radius          | (Numeric) eg. 0.2                                                                  | Radius for circular robot                              |
+-----------------+------------------------------------------------------------------------------------+--------------------------------------------------------+
| vertices        | (List) eg. [[-0.205, -0.155], [-0.205, 0.155], [0.077, 0.155], [0.077, -0.155]]    | List of vertices for the robot polygon.                |
+-----------------+------------------------------------------------------------------------------------+--------------------------------------------------------+
| padding         | (String) eg "0.01                                                                  | Padding for the robot. Think of this as extra distance |
|                 |                                                                                    | from the robot for safety reasons.                     |
+-----------------+------------------------------------------------------------------------------------+--------------------------------------------------------+

**6. Cost Footprints**


+------------------------+---------------------+-----------------------------------------------------------------------------------------------+
| Parameter              | Values              | Description                                                                                   |
+========================+=====================+===============================================================================================+
| pdist_scale            | (Numeric) eg 1.8    | Increasing this value makes the algorithm prefer paths that are closer to the global path     |
+------------------------+---------------------+-----------------------------------------------------------------------------------------------+
| gdist_scale            | (Numeric) eg. 1.0   | Increasing this value makes the algorithm prefer paths that are closer to the goal.           |
+------------------------+---------------------+-----------------------------------------------------------------------------------------------+
| occdist_scale          | (Numeric) eg. 0.4   | Increasing this value makes the algorithm prefer paths that are farther from                  |
|                        |                     | obstacles. Try increasing if the robot is straying too close to obstacles.                    |
+------------------------+---------------------+-----------------------------------------------------------------------------------------------+

Files to alter for Tuning
^^^^^^^^^^^^^^^^^^^^^^^^^

The following files need to be altered and saved for custom parameters to take effect.

**1. turtle_mowito**


+-------------------------+---------------------------------------------------------------------------------------------------+
| Trajectory Planner      | mowito_ws/src/turtle_mowito/mowito_turtlebot/config/controller_config/trajectory_planner_ros.yaml |
+-------------------------+---------------------------------------------------------------------------------------------------+
| Local Costmap           | mowito_ws/src/turtle_mowito/mowito_turtlebot/config/costmap_config/local_costmap_params.yaml      |
+-------------------------+---------------------------------------------------------------------------------------------------+
| Global Costmap          | mowito_ws/src/turtle_mowito/mowito_turtlebot/config/costmap_config/global_costmap_params.yaml     |
+-------------------------+---------------------------------------------------------------------------------------------------+

**2. rosbot**


+-------------------------+---------------------------------------------------------------------------------------------------+
| Trajectory Planner      | mowito_ws/src/gazebo_sim/src/rosbot_description/config/controller/trajectory_planner_ros.yaml     |
+-------------------------+---------------------------------------------------------------------------------------------------+
| Local Costmap           | mowito_ws/src/costmap2d/config/local_costmap_params.yaml                                          |
+-------------------------+---------------------------------------------------------------------------------------------------+
| Global Costmap          | mowito_ws/src/costmap2d/config/global_costmap_params.yaml                                         |
+-------------------------+---------------------------------------------------------------------------------------------------+

  

Common Problems and Tuning
^^^^^^^^^^^^^^^^^^^^^^^^^^

This section describes certain common problems and describes in more detail how changing parameters will affect the robot behaviour.

**Tip**

Traditionally, one may edit and save the parameter files and relaunch the navigation to see their affect. It is highly recommended to use rqt_reconfigure, a ros utility that allows changing parameters during execution. Thus, there is no need to relaunch the navigation node(s). To use rqt_reconfigure, open a separate terminal (source the ros) and run

  ``rosrun rqt_reconfigure rqt_reconfigure``

A window like this would appear

.. image:: Images/trajectory_planner/rqt_reconfigure.png
  :alt: rqt_reconfigure.png

**Usage**

  * Make sure all parameters have the correct values.
  * Change the values using either the sliders or the boxes next to the sliders
  * After tuning, make sure to save your new parameters by changing them in the files listed above so that they are loaded each time the navigation is launched.
  * It is recommended to make a backup of the original parameter files.




**A. Local path is curving a lot and causes the robot to be slow and move in a sine wave-like path.**


This happens because of the path cost solution (pdist_bias, gdist_bias and occdist_bias params)
Increasing the pdist bias will cause the robot to move closer to the global path, thereby reducing the 'sinusoidal' behaviour of the robot.
  
.. image:: Images/trajectory_planner/pdist_15.png
  :alt: pdist_15.png

*pdist_bias is set to 1.5*


.. image:: Images/trajectory_planner/pdist_40.png
  :alt: pdist_40.png

*pdist_bias is set to 4.0*

**B. The robot is not following the global path that goes between obstacles when the opening is small or the robot comes close to the obstacle and gets stuck.**

The robot comes close to obstacles because either the global path or the local path is not far enough from obstacles. It is suggested to tweak the inflation_radius and cost_scaling_factors to avoid this.

Obstacles exert a 'cost' on the map. For this purpose, the map is divided into a grid-based on a resolution. Think of this as pixels on a screen. A higher resolution means more points on the map. For each point, the cost is calculated. Thus, a higher resolution would require more computation power. Keep in mind that the resolution should be lower than that of the laser scanner hardware mounted on the robot.

The collection of all these points with their costs is called a 'costmap'. The cost of each pixel is used to determine how close the robot is to the object relative to how close it should be. This is not an actual estimate, only a numerical one that scales inversely with distance to the object and gives the robot a sense for how close it is to an obstacle. For example, the points close the obstacle will have a cost value close to 255, and cost would decrease the farther away we go from the obstacle. The rate of decrease and the limit of the obstacle's influence can be changed by tweaking the inflation_radius and cost_scaling_factor.
    
  **Inflation radius**
  Inflation radius sets the absolute limit till which an object exerts influence or cost. Starting from the inflation radius and beyond, the costmap will have 0 cost due to the obstacle.
  
  **Cost Scaling Factor**
  This factor defines how steeply or gradually the cost will decrease as we move farther away from the obstacle. It is inversely proportional to the cost of a cell. So a higher value means the costs decrease quickly as we move farther from an obstacle. A lower value would lead to a more gentle slope.

It is recommended to set inflation_radius and cost_scaling_factor such that slopes are gentler and move a decent distance away from the obstacle. This allows the global path planner and trajectory planner to find the 'midway' path between obstacles and not stray too close to one obstacle.
In the examples below, a higher cost is indicated by darker shade for the 'pixel' or grid-cell.

.. image:: Images/trajectory_planner/costmap_rad_02.png
  :alt: costmap_rad_02.png

*inflation_radius: 0.2, cost_scaling_factor: 3.0*

.. image:: Images/trajectory_planner/costmap_rad_15.png
  :alt: costmap_rad_02.png

*inflation_radius: 1.5, cost_scaling_factor: 3.0*

Notice how in the first case, the global path goes close to the obstacles, while in the second case, a path that is roughly equidistant from all obstacles is chosen.

.. image:: Images/trajectory_planner/costmap_csf_150.png
  :alt: costmap_rad_02.png

*inflation_radius: 1.5, cost_scaling_factor: 15.0*

Notice how in this case, the scaling factor is high and the costmap around obstacles is steep. This means the cost reaches zero quickly and the global path changes. While this may look similar to the first case, notice that in the first case the costmap slope is gradual but the inflation radius is short and the costmap around an obstacle terminates quickly because of the short radius. In this case, the radius is more than enough but the costmap is steep and reaches zero cost.

Ths same parameters are also tweaked for the local costmap used by the trajectory planner (Yes, the costmap used by the global planner is global costmap, while that used by trajectory planner is local costmap).


For instance, take global costmap parameters as:

    - inflation_radius: 0.2
    - cost_scaling_factor: 3.0

.. image:: Images/trajectory_planner/local_costmap_rad_01.png
  :alt: costmap_rad_02.png

Local Costmap *cost_scaling_factor: 3.0, inflation_radius: 0.1*


.. image:: Images/trajectory_planner/local_costmap_rad_08.png
  :alt: costmap_rad_02.png

Local Costmap *cost_scaling_factor: 3.0, inflation_radius: 0.8*


Notice how the robot is considering a larger area and that the path it took is relatively farther from obstacles than it is in the first case. The change can be increased by tuning the cost_scaling_factor and inflation_radius. If the inflation radius is too large, the robot may try to avoid narrow pathways.


**C. The calculation needs too much time to stay at moving frequency**


The number of times this warning occurs can be reduced by tweaking parameters to use less computational resources. Try reducing local costmap width and height. This is an effective method to reduce computation time.

Other methods to reduce computation time:

  - Increase sim_granularity
  - Reduce vx_samples and/or vtheta_samples
  - Reduce sim_time

**D. The robot is able to reach the first goal but fails for subsequent ones.**


The cause is unknown. Reducing heading_lookahead for trajectory planner may fix the issue. Try the value 0.325


Controller: Pure Pursuit Tuning Guide
-------------------------------------

Description
^^^^^^^^^^^
Pure pursuit algorithm works by calculating the curvature that will move a vehicle from its current position to some goal position. The main part of the algorithm is to choose a goal position that is some distance ahead of the vehicle on the path. We can think of the vehicle as chasing a point on the path some distance ahead of it - it is pursuing that moving point. This look-ahead distance changes as we drive to reflect the twist of the path.

It is a proportional type controller and follows the global path more accurately. It is computationally fast and is well suited for situations when the robot has to follow a path exactly and doesn’t have to worry about obstacles.


Parameter Description
^^^^^^^^^^^^^^^^^^^^^

The performance of the pure pursuit controller is highly influenced by its parameters. The following parameters should be tuned for a customized behaviour. 

+------------------------+------------+--------------------------------------------------------------------------------------+
| Parameter              | Units      | Description                                                                          |
+========================+============+======================================================================================+
| min_lookahead          | S.I        | minimum lookahead distance                                                           |
+------------------------+------------+--------------------------------------------------------------------------------------+
| max_lookahead          | S.I        | maximum lookahead distance                                                           |
+------------------------+------------+--------------------------------------------------------------------------------------+
| closest_point_index    | number     | search for closest point index within this range of previous closest point           |
+------------------------+------------+--------------------------------------------------------------------------------------+
| max_acceleration       | S.I        | maximum acceleration                                                                 |
+------------------------+------------+--------------------------------------------------------------------------------------+
| max_velocity           | S.I        | maximum velocity                                                                     |
+------------------------+------------+--------------------------------------------------------------------------------------+
| min_velocity           | S.I        | minimum velocity                                                                     |
+------------------------+------------+--------------------------------------------------------------------------------------+
| max_omega              | S.I        | maximum angular velocity                                                             |
+------------------------+------------+--------------------------------------------------------------------------------------+
| max_radius             | S.I        | maximum radius the robot can take from current to goal pose                          |
+------------------------+------------+--------------------------------------------------------------------------------------+
| min_radius             | S.I        | minimum radius the robot can take from current to goal pose                          |
+------------------------+------------+--------------------------------------------------------------------------------------+
| max_omega_radius       | S.I        | radius set when condition for straight line is satisfied                             |
+------------------------+------------+--------------------------------------------------------------------------------------+
| max_y_deviation        | S.I        | Maximum deviation in the lateral direction                                           |
+------------------------+------------+--------------------------------------------------------------------------------------+
| max_path_deviation     | S.I        | maximum path deviation between current and goal pose                                 |
+------------------------+------------+--------------------------------------------------------------------------------------+
| max_theta_deviation    | S.I        | maximum heading difference                                                           |
+------------------------+------------+--------------------------------------------------------------------------------------+
| transform_tolerance    | S.I        | transform tolerance in seconds for pose in robot frame                               |
+------------------------+------------+--------------------------------------------------------------------------------------+


Files to alter for Tuning
^^^^^^^^^^^^^^^^^^^^^^^^^

The following files need to be altered and saved for custom parameters to take effect.

**1. turtle_mowito**


+------------------------+---------------------------------------------------------------------------------------------------+
| Pure Pursuit Controller| mowito_ws/src/turtle_mowito/mowito_turtlebot/config/controller_config/pure_pursuit_controller.yaml|
+------------------------+---------------------------------------------------------------------------------------------------+

**2. rosbot**


+------------------------+---------------------------------------------------------------------------------------------------+
| Pure Pursuit Controller| mowito_ws/src/gazebo_sim/src/rosbot_description/config/controller/pure_pursuit_controller.yaml    |
+------------------------+---------------------------------------------------------------------------------------------------+

  

Common Problems and Tuning
^^^^^^^^^^^^^^^^^^^^^^^^^^

This section describes certain common problems and describes in more detail how changing parameters will affect the robot behaviour.

**Tip**


You can use rqt_reconfigure tool for configuring the parameters during the run time. To use it, use the following command on a new terminal :
    
    ``rosrun rqt_reconfigure rqt_reconfigure``

.. image:: Images/pure_pursuit/PP_3.png
  :alt: PP_3.png
  :align: center

**Initial Check**

  - Make sure that the maximum acceleration is not set to zero.
  - Make sure that the maximum y deviation is not set to zero.
  - Make sure that the min and max radius are not equal (same for lookahead and  velocities).
  - Make sure that the minimum lookahead distance is in front of the robot. As the size of your robot increases the minimum lookahead distance 	 should increase.
  - Make sure that the path given to the robot does not have any obstacles in its way else the robot might get stuck.

**A. Robot is not following the global path accurately when taking a hard turn**


.. image:: Images/pure_pursuit/PP_1.png
  :alt: PP_1.png
  :align: center

Pure pursuit controller while taking a turn has to take a minimum radius value for the turn. This is what happens when the robot is asked to take a 90 degree turn. It takes a minimum radius value(here 0.2) to make that quadrant after which it slowly comes back to the global path. Instead, try to give the path to be followed by the robot to have some curvature as this will lead to a much smoother movement i.e follows the global path more accurately(using set_route) and also increase this radius for bigger robots. Example:
  
.. image:: Images/pure_pursuit/PP_2.png
  :alt: PP_2.png
  :align: center

**B. The robot oscillates a lot while approaching a turn**

Make sure that the lookahead goal is in front of the robot and not underneath it. Also, reduce the maximum angular velocity for a smoother motion.


**C. The robot is unable/takes more time to follow its path after taking a turn**  


Increase the closest point search index to include more number of points to choose from and also check the minimum lookahead goal.


Controller: Teb Local Planner Tuning Guide
------------------------------------------

Description
^^^^^^^^^^^
Teb implements an online optimal local trajectory planner for navigation and control of mobile robots. The initial trajectory generated by a global planner is optimized during runtime w.r.t. minimizing the trajectory execution time (time-optimal objective), separation from obstacles and compliance with kinodynamic constraints such as satisfying maximum velocities and accelerations.

The optimal trajectory is efficiently obtained by solving a sparse scalarized multi-objective optimization problem. The user can provide weights to the optimization problem in order to specify the behavior in case of conflicting objectives.

Since local planners such as the Timed-Elastic-Band get often stuck in a locally optimal trajectory as they are unable to transit across obstacles, an extension is implemented. A subset of admissible trajectories of distinctive topologies is optimized in parallel. The local planner is able to switch to the current globally optimal trajectory among the candidate set. Distinctive topologies are obtained by utilizing the concept of homology / homotopy classes.

Parameter Description
^^^^^^^^^^^^^^^^^^^^^

The teb_local_planner package allows the user to set parameters in order to customize the behavior. These parameters are grouped into several categories: robot configuration, goal tolerance, trajectory configuration, obstacles, optimization, planning in distinctive topologies and miscellaneous parameters.

**1. Trajectory Configuration Parameters**

+-----------------------------------+------------+---------------------------------------------------------------------------+
| Parameter                         | Values     | Description                                                               |
+===================================+============+===========================================================================+
| teb_autosize                      | true/false | If set to true automatic resizing occurs                                  |
+-----------------------------------+------------+---------------------------------------------------------------------------+
| dt_ref                            | number     | Desired temporal resolution of the trajectory (the trajectory is not fixed|
|                                   | 	         | to dt_ref since the temporal resolution is part of the optimization, but  |
|                                   |            | the trajectory will be resized between iterations if dt_ref               |
|                                   |            | +-dt_hysteresis is violated.                                              |
+-----------------------------------+------------+---------------------------------------------------------------------------+
| dt_hysteresis                     | number     | Hysteresis for automatic resizing depending on the current temporal       |
|                                   |            | resolution, usually approx 10% of dt_ref is recommended                   |
+-----------------------------------+------------+---------------------------------------------------------------------------+
| global_plan_overwrite_orientation | true/false | Overwrite orientation of local subgoals provided by the global planner    |
|                                   |            | (since they often provide only a 2D path)                                 |
+-----------------------------------+------------+---------------------------------------------------------------------------+
| max_global_lookahead_dist         | S.I        | Specify the maximum length (cumulative Euclidean distances) of the subset |
|                                   |            | of the global plan taken into account for optimization. The actual length |
|                                   |            | is then determined by the logical conjunction of the local costmap size   |
|                                   |            | and this maximum bound. Set to zero or negative in order to deactivate    |
|                                   |            | this limitation.                                                          | 
+-----------------------------------+------------+---------------------------------------------------------------------------+
| feasibility_check_no_poses        | number     | Specify up to which pose on the predicted plan the feasibility should be  |
|                                   |            | checked each sampling interval.                                           |
+-----------------------------------+------------+---------------------------------------------------------------------------+
| min_samples                       | number     | Minimum number of samples( always greater than 2)                         |
+-----------------------------------+------------+---------------------------------------------------------------------------+
| max_samples                       | number     | Maximum number of samples                                                 |
+-----------------------------------+------------+---------------------------------------------------------------------------+

**2. Robot Configuration Parameters**

+------------------------+------------+--------------------------------------------------------------------------------------+
| Parameter              | Units      | Description                                                                          |
+========================+============+======================================================================================+
| max_vel_x              | S.I        | Maximum translational velocity of the robot                                          |
+------------------------+------------+--------------------------------------------------------------------------------------+
| max_vel_x_backwards    | S.I        | Maximum absolute translational velocity of the robot while moving backwards          |
+------------------------+------------+--------------------------------------------------------------------------------------+
| max_vel_theta          | S.I        | Maximum angular velocity of the robot                                                |
+------------------------+------------+--------------------------------------------------------------------------------------+
| acc_lim_x              | S.I        | Maximum translational acceleration of the robot                                      |
+------------------------+------------+--------------------------------------------------------------------------------------+
| acc_lim_theta          | S.I        | Maximum angular acceleration of the robot                                            |
+------------------------+------------+--------------------------------------------------------------------------------------+
| min_turning_radius     | S.I        | Maximum turning radius of a car like robot (set to zero for diff-drive robot)        |
+------------------------+------------+--------------------------------------------------------------------------------------+

**3. Robot Footprint Parameters**

+-----------------------------------+------------+---------------------------------------------------------------------------+
| Parameter                         | Values     | Description                                                               |
+===================================+============+===========================================================================+
| type                              | point,     | Type of robot                                                             |
|                                   | circular,  |                                                                           |
|                                   | two_circles|                                                                           |
|		                    | ,line,     |                                                                           |
|				    | polygon    |                                                                           |
+-----------------------------------+------------+---------------------------------------------------------------------------+
| radius                            | Numeric    | Radius for circular robot                                                 |
|                                   | eg. 0.2	 |                                                                           |
+-----------------------------------+------------+---------------------------------------------------------------------------+
| line_start                        | Eg. [-0.3, | It contains the start coordinates of the line segment for type "line"     |
|                                   | 0.0]       |                                                                           |
+-----------------------------------+------------+---------------------------------------------------------------------------+
| line_end                          | Eg. [0.3,  | It contains the end coordinates of the line segment for type "line"       |
|                                   | 0.0]       |                                                                           |
+-----------------------------------+------------+---------------------------------------------------------------------------+
| front_offset                      | Numeric    | It describes how much the center of the font circle is shifted along the  |
|                                   | eg. 0.2    | robot's x-axis. The robot's axis of rotation is assumed to be located at  |
|                                   |            | [0,0] for type "two_circles"                                              | 
+-----------------------------------+------------+---------------------------------------------------------------------------+
| front_radius                      | Numeric    | Contains the radius of the front circle for type "two_circles"            |
|                                   | eg. 0.2    |                                                                           |
+-----------------------------------+------------+---------------------------------------------------------------------------+
| rear_offset                       | Numeric    | It describes how much the center of the font circle is shifted along the  |
|                                   | eg. 0.2    | robot's negative x-axis. The robot's axis of rotation is assumed to be    |
|                                   |            | located at [0,0] for type "two_circles"                                   | 
+-----------------------------------+------------+---------------------------------------------------------------------------+
| rear_radius                       | Numeric    | Contains the radius of the front circle for type "two_circles"            |
|                                   | eg. 0.2    |                                                                           |
+-----------------------------------+------------+---------------------------------------------------------------------------+
| vertices                          | Eg.[[0.1,  | It contains the list of polygon vertices (2D coordinates each). The       |
|                                   | 0.1],[0.1, | polygon is always closed: do not repeat the first vertex at the end for   |
|                                   | -0.1],[-0.1| type "polygon"                                                            |
|                                   | ,-0.1],[-0.|                                                                           |
|                                   | 1,0.1]]    |                                                                           |
+-----------------------------------+------------+---------------------------------------------------------------------------+

**4. Goal Tolerance Parameters**


+------------------------+------------+--------------------------------------------------------------------------------------+
| Parameter              | Units      | Description                                                                          |
+========================+============+======================================================================================+
| xy_goal_tolerance      | S.I        | Maximum allowable deviation in robot position from the goal position.                |
+------------------------+------------+--------------------------------------------------------------------------------------+
| yaw_goal_tolerance     | S.I        | Specifies the maximum allowable angular deviation in the robot orientation from the  |
|                        |            | goal orientation.                                                                    |
+------------------------+------------+--------------------------------------------------------------------------------------+
| free_goal_vel          | true/false | when set to false removes the goal velocity constraint such that the robot can arrive|
|                        |            | at the goal with maximum velocity.                                                   |
+------------------------+------------+--------------------------------------------------------------------------------------+

**5. Obstacle Parameters**


+------------------------------------+------------+--------------------------------------------------------------------------------------+
| Parameter                          | Values     | Description                                                                          |
+====================================+============+======================================================================================+
| min_obstacle_dist                  | S.I        | Minimum desired separation from obstacles in meters                                  |
+------------------------------------+------------+--------------------------------------------------------------------------------------+
| include_costmap_obstacles          | true/false | Specify if obstacles of the local costmap should be taken into account. Each cell    | 
|                                    |            | that is marked as an obstacle is considered as a point-obstacle. Therefore do not    | 
|                                    |            | choose a very small resolution of the costmap since it increases computation time.   |
+------------------------------------+------------+--------------------------------------------------------------------------------------+
| costmap_obstacles_behind_robot_dist| S.I        | Limit the occupied local costmap obstacles taken into account for planning behind the|
|                                    |            | robot (specify distance in meters)                                                   | 
+------------------------------------+------------+--------------------------------------------------------------------------------------+
| obstacle_poses_affected            | number     | Each obstacle position is attached to the closest pose on the trajectory in order to | 
|                                    |            | keep a distance. Additional neighbors can be taken into account as well. Default     |
|                                    |            | value is 30                                                                          |
+------------------------------------+------------+--------------------------------------------------------------------------------------+
| costmap_converter_plugin           | string     | Define plugin name in order to convert costmap cells to points/lines/polygons. Set an|
|                                    |            | empty string to disable the conversion such that all cells are treated as            | 
|                                    |            | point-obstacles.                                                                     |
+------------------------------------+------------+--------------------------------------------------------------------------------------+
| costmap_converter_spin_thread      | true/false | If set to true, the costmap converter invokes its callback queue in a different      | 
|                                    |            | thread.                                                                              |
+------------------------------------+------------+--------------------------------------------------------------------------------------+
| costmap_converter_rate             | number(Hz) | Rate that defines how often the costmap_converter plugin processes the current       |
|                                    |            | costmap (the value should not be much higher than the costmap update rate) [in Hz]   |
+------------------------------------+------------+--------------------------------------------------------------------------------------+

**6. Optimization Parameters**


+------------------------------------+------------+--------------------------------------------------------------------------------------+
| Parameter                          | Values     | Description                                                                          |
+====================================+============+======================================================================================+
| no_inner_iterations                | number     | Number of actual solver iterations called in each outer loop iteration. See param    | 
|                                    |            | no_outer_iterations.                                                                 |
+------------------------------------+------------+--------------------------------------------------------------------------------------+
| no_outer_iterations                | number     | Each outer loop iteration automatically resizes the trajectory according to the      | 
|                                    |            | desired temporal resolution dt_ref and invokes the internal optimizer (that performs | 
|                                    |            | no_inner_iterations). The total number of solver iterations in each planning cycle is| 
|                                    |            | therefore the product of both values.                                                |
+------------------------------------+------------+--------------------------------------------------------------------------------------+
| optimization_activate              | true/false | Set to true for activating optimization                                              | 
+------------------------------------+------------+--------------------------------------------------------------------------------------+
| optimization_verbose               | true/false | Print the optimization steps                                                         | 
+------------------------------------+------------+--------------------------------------------------------------------------------------+
| penalty_epsilon                    | number     | Add a small safety margin to penalty functions for hard-constraint approximations    |
+------------------------------------+------------+--------------------------------------------------------------------------------------+
| weight_max_vel_x                   | number     | Optimization weight for satisfying the maximum allowed translational velocity        |
+------------------------------------+------------+--------------------------------------------------------------------------------------+
| weight_max_vel_theta               | number     | Optimization weight for satisfying the maximum allowed angular velocity              |
+------------------------------------+------------+--------------------------------------------------------------------------------------+
| weight_acc_lim_x                   | number     | Optimization weight for satisfying the maximum allowed translational acceleration    |
+------------------------------------+------------+--------------------------------------------------------------------------------------+
| weight_acc_lim_theta               | number     | Optimization weight for satisfying the maximum allowed angular acceleration          |
+------------------------------------+------------+--------------------------------------------------------------------------------------+
| weight_kinematics_nh               | number     | Optimization weight for satisfying the non-holonomic kinematics (this parameter must |
|                                    |            | be high since the kinematics equation constitutes an equality constraint, even a     | 
|                                    |            | value of 1000 does not imply a bad matrix condition due to small 'raw' cost values in| 
|                                    |            | comparison to other costs).                                                          |
+------------------------------------+------------+--------------------------------------------------------------------------------------+
| weight_kinematics_forward_drive    | number     | Optimization weight for forcing the robot to choose only forward directions          | 
|                                    |            | positive transl. velocities). A small weight (e.g. 1.0) still allows driving         | 
|                                    |            | backwards. A value around 1000 almost prevents backward driving (but cannot be       |  
|                                    |            | guaranteed).                                                                         |
+------------------------------------+------------+--------------------------------------------------------------------------------------+
| weight_kinematics_turning_radius   | number     | Optimization weight for enforcing a minimum turning radius (only for car like robots)|
+------------------------------------+------------+--------------------------------------------------------------------------------------+
| weight_optimaltime                 | number     | Optimization weight for contracting the trajectory w.r.t transition/execution time   |
+------------------------------------+------------+--------------------------------------------------------------------------------------+
| weight_obstacle                    | number     | Optimization weight for keeping a minimum distance from obstacles                    |
+------------------------------------+------------+--------------------------------------------------------------------------------------+

**7. Homotopy Parameters**


+------------------------------------+------------+--------------------------------------------------------------------------------------+
| Parameter                          | Values     | Description                                                                          |
+====================================+============+======================================================================================+
| enable_homotopy_class_planning     | true/false | Activate parallel planning in distinctive topologies (requires much more CPU         | 
|                                    |            | resources)                                                                           |
+------------------------------------+------------+--------------------------------------------------------------------------------------+
| enable_multithreading              | true/false | Activate multiple threading in order to plan each trajectory in a different thread   |
+------------------------------------+------------+--------------------------------------------------------------------------------------+
| simple_exploration                 | true/false | to use it for exploration set value to true                                          |
+------------------------------------+------------+--------------------------------------------------------------------------------------+
| max_number_classes                 | number     | Specify the maximum number of distinctive trajectories taken into account (limits    |    
|                                    |            | computational effort)                                                                |
+------------------------------------+------------+--------------------------------------------------------------------------------------+
| roadmap_graph_no_samples           | number     | Specify the number of samples generated for creating the roadmap graph               |
+------------------------------------+------------+--------------------------------------------------------------------------------------+
| roadmap_graph_area_width           | S.I        | Random waypoints are sampled in a rectangular region between start and goal. Specify | 
|                                    |            | the width of that region in meters.                                                  |
+------------------------------------+------------+--------------------------------------------------------------------------------------+
| h_signature_prescaler              | number     | Scale internal parameter (H-signature) that is used to distinguish between homotopy  |  
|                                    |            | classes. Warning: reduce this parameter only, if you observe problems with too many  |  
|                                    |            | obstacles in the local cost map, do not choose it extremely low, otherwise obstacles |
|                                    |            | cannot be distinguished from each other (0.2<value<=1).                              |
+------------------------------------+------------+--------------------------------------------------------------------------------------+
| h_signature_threshold              | number     | Two H-signatures are assumed to be equal, if both the difference of real parts and   | 
|                                    |            | complex parts are below the specified threshold.                                     |
+------------------------------------+------------+--------------------------------------------------------------------------------------+
| obstacle_heading_threshold         | number     | Specify the value of the scalar product between obstacle heading and goal heading in | 
|                                    |            | order to take them (obstacles) into account for exploration.                         |
+------------------------------------+------------+--------------------------------------------------------------------------------------+
| visualize_hc_graph                 | true/false | Visualize the graph that is created for exploring distinctive trajectories.          |
+------------------------------------+------------+--------------------------------------------------------------------------------------+

**8. Miscellaneous Parameters**


+------------------------------------+------------+--------------------------------------------------------------------------------------+
| Parameter                          | Values     | Description                                                                          |
+====================================+============+======================================================================================+
| Odom_topic                         | Eg. /odom  | Topic name of the odometry message                                                   |
+------------------------------------+------------+--------------------------------------------------------------------------------------+
| map_frame                          | Eg. /map   | Global planning frame                                                                |
+------------------------------------+------------+--------------------------------------------------------------------------------------+


Files to alter for Tuning
^^^^^^^^^^^^^^^^^^^^^^^^^

The following files need to be altered and saved for custom parameters to take effect.

**1. turtle_mowito**


+------------------------+---------------------------------------------------------------------------------------------------+
| Teb local planner      | mowito_ws/src/turtle_mowito/mowito_turtlebot/config/controller_config/teb_local_planner_ros.yaml  |
+------------------------+---------------------------------------------------------------------------------------------------+
| Local Costmap          | mowito_ws/src/turtle_mowito/mowito_turtlebot/config/costmap_config/local_costmap_params.yaml      |
+------------------------+---------------------------------------------------------------------------------------------------+
| Global Costmap         | mowito_ws/src/turtle_mowito/mowito_turtlebot/config/costmap_config/global_costmap_params.yaml     |
+------------------------+---------------------------------------------------------------------------------------------------+

**2. rosbot**


+------------------------+---------------------------------------------------------------------------------------------------+
| Teb local planner      | mowito_ws/src/gazebo_sim/src/rosbot_description/config/controller/teb_local_planner_ros.yaml      |
+------------------------+---------------------------------------------------------------------------------------------------+
| Local Costmap          | mowito_ws/src/costmap2d/config/local_costmap_params.yaml                                          |
+------------------------+---------------------------------------------------------------------------------------------------+
| Global Costmap         | mowito_ws/src/costmap2d/config/global_costmap_params.yaml                                         |
+------------------------+---------------------------------------------------------------------------------------------------+

  

Common Problems and Tuning
^^^^^^^^^^^^^^^^^^^^^^^^^^

This section describes certain common problems and describes in more detail how changing parameters will affect the robot behaviour.

**Tip**


You can use rqt_reconfigure tool for configuring the parameters during the run time. To use it, use the following command on a new terminal :
    
    ``rosrun rqt_reconfigure rqt_reconfigure``

.. image:: Images/teb_local_planner/teb_5.png
  :alt: teb_5.png
  :align: center

**A. Why does my robot navigate too close to the walls?**


.. image:: Images/teb_local_planner/teb_1.png
  :alt: teb_1.png
  :align: center

The local planner follows a moving virtual goal on the global plan. Therefore locations of intermediate global plan positions of the global plan significantly influence the spatial behavior of the local plan. By defining an inflation radius the global planner prefers plans with minimum cost and hence plans with a higher separation from walls. The resulting motion is time-optimal w.r.t. the virtual goal. If your robot hits walls, you should increase min_obstacle_dist or set up an appropriate footprint. Otherwise, increase the inflation radius in costmap configuration.

.. image:: Images/teb_local_planner/teb_2.png
  :alt: teb_2.png
  :align: center

**B. Why is the robot not following the global plan properly?**


Following the global plan is achieved by targeting a moving virtual goal taken from intermediate global plan positions within the scope of the local costmap (in particular a subset of the global plan with length max_global_plan_lookahead_dist). The local plan between the current robot position and the virtual goal is subject to optimization, e.g. to minimization of the transition time. If the robot should prefer to follow the global plan instead of reaching the (virtual) goal in minimum time, a first strategy could be to significantly reduce max_global_plan_lookahead_dist. But this approach is NOT recommended, since it reduces the prediction/planning horizon and weakens the capabilities of avoiding obstacles . Instead, in order to account for global path following, the teb_local_planner is able to inject attractors (via-points) along the global plan (distance between attractors: global_plan_viapoint_sep > 0 (Eg. 1.0), attraction strength: weight_viapoint > 1 (Eg. 10.0)). Use the publish point option in Rviz to set the via points.

**C. Why is there a gap in the trajectory generated by teb local planner?**


.. image:: Images/teb_local_planner/teb_3.png
  :alt: teb_3.png
  :align: center

Parameter min_obstacle_dist is chosen too high. If the parameter min_obstacle_dist is set to a distance of 1m, the robot tries to keep a distance of at least 1m to each side of the door. But if the width of the door is just 1m, the optimizer will still plan through the center of the door. But in order to satisfy the minimum distance to each pose the optimizer moves the planned poses along the trajectory (therefore the gap!). If you really have to keep large distances to obstacles you cannot drive through that door. Then you must also configure your global planner (robot footprint, inflation etc.) properly to avoid global planning through it. Otherwise reduce the minimum distance until the trajectory does not contain any large gap.

**D. Computation takes too much time. How to speed up the planning?**


The following list provides a brief overview and implications of parameters that influence the computation time significantly.

Local costmap_2D configuration (a rolling window is highly recommended!):
	**width/height:**
	Size of the local costmap: implies maximum trajectory length and how many occupied cells are taken into account (major impact on computation time, but if too small: short prediction/planning horizon reduces the degrees of freedom, e.g. for obstacle avoidance).

	**resolution:**
	Resolution of the local costmap: a fine resolution (small values) implies many obstacles subject to optimization (major impact on computation time).

Obstacle/Costmap parameters of the teb_local_planner:
	**costmap_obstacles_behind_robot_dist:**
	Since the local costmap is centered at the current robot position, not all obstacles behind the robot must be taken into account. To allow safe turning behaviors, this value should be non-zero. A higher value includes more obstacles for optimization.

	**obstacle_poses_affected:**
	Number of nearest neighbors on the trajectory taken into account (increases the number of distance calculations for each obstacle). For small obstacles and point obstacles, this value can be small (<10). Increase the value again if the trajectory is not smooth enough close to obstacles.

	**footprint_model:**
	The robot footprint model influences the runtime, since the complexity of distance calculation is increased (avoid a polygon footprint if possible).
 
Trajectory representation:
	**dt_ref:**
	Determines the desired resolution of the trajectory: small values lead to a fine resolution and thus a better approximation of the kinodynamic model, but many points must be optimized (major impact on optimization time). Too high values (> 0.6s) can lead to trajectories that are not feasible anymore due to the poor approximation of the kinodynamic model (especially in case of car-like robots).

	**max_global_plan_lookahead_dist:**
	Limits the distance to the virtual goal (along the global plan) and thus the number of poses subject to optimization (temporal distance between poses approx dt_ref seconds). But the length is also bounded by the local costmap size

Optimization parameters:
	**no_inner_iterations:**
	Number of solver calls in each "outer-iteration". Highly influences the computation time but also the quality of the solution.

	**no_outer_iterations:**
	Number of outer iterations for each sampling interval that specifies how often the trajectory is resized to account for dt_ref and how often associations between obstacles and planned poses are renewed. Also the solver is called each iteration. The value significantly influences the computation time as well as convergence properties.

	**weight_acc_lim_:**
	You can ignore acceleration limits by setting the weight to 0.0. By doing so the complexity of the optimization and hence the computation time can be reduced.


Parallel planning of alternative trajectories:
	**enable_homotopy_class_planning:**
	If you only have timing problems in case multiple alternatives are computed, set the alternative planning to false or first restrict the number of alternatives using max_number_classes.

	**max_number_classes:**
	Restrict the number of alternative trajectories that are subject to optimization. Often 2 alternatives are sufficient (avoid obstacles on the left or right side).

**E. Why does the robot oscillate if the goal is near an obstacle?**


.. image:: Images/teb_local_planner/teb_4.png
  :alt: teb_4.png
  :align: center

This is because the value of inflation radius and min_obstacle_dist are set pretty low. Note that if you are using a point footprint model the min_obstacle_dist must also include the radius of the robot. Set the inflation radius greater than the min_obstacle_dist and also make sure that the robot follows the global plan more accurately to reduce the oscillations. 

