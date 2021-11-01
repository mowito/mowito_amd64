==============================================
MaxL Controller Tuning Guide
==============================================
This is a guide that will describe the steps to tune the MaxL controller for any deployment of the Mowito Navigation Stack. This guide shall provide all the parameters that are required to be tuned, their significance and description of what the parameters mean. 

This guide is typically meant for the end users who will be using the Mowito Navigation stack and have deployed the navigation stack on their respective hardware. This guide will only address the controller and obstacle avoidance functionality of the Mowito Navigation Stack.


-----------------------------------------
Steps to tuning the MaxL Controller
-----------------------------------------

The MaxL controller is a proprietary state of the art control and obstacle avoidance system that has the ability to process information and control the robot and avoid obstacles with a refresh rate as high as 50 Hz. In order to use the MaxL controller provided in the Mowito Navigation Stack, the controller is required to be tuned.

The following flow chart shall highlight the steps to follow for tuning the MaxL controller.

.. image:: Images/maxl/stages.png
   :align: center

The process of tuning the controller involves two major steps :

----------------------------------------------------------
Step 1 : Generating Motion Primitives for the Controller
----------------------------------------------------------

The Motion Primitives are a set of precomputed paths that the robot can take while the robot is in motion. Whenever an obstacle confronts the robot, some of the precomputed paths are blocked and the controller chooses a path from the set of paths that are not blocked. 

While tuning the controller generation of these precomputed paths is a mandatory first step. To generate the motion primitives, the following information is required :

1. Robot Length
2. Robot Width 

The motion primitives would be generated using a tool provided by Mowito. 

Here are the steps to generate the motion primitives:

Accessing the motion primitives generator web tool
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The motion primitives are generated using a web tool developed by Mowito. So inoder to generate the motion primitives, the user must access the web tool.

`Here is the link to the web tool <http://ec2-15-207-68-243.ap-south-1.compute.amazonaws.com/>`_

Upon accessing the web tool, the user will land onto the following page : 

.. image:: Images/maxl/mprim_generator.png
   :align: center

Setting the motion primitive parameters to generate the motion primitives
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Inorder to generate the motion primitives, certain parameters are required to be set. The parameters that are required to be set by the user are :

1. Path Distance or simply Distance
2. Search Radius

The aforementioned parameters are the **ONLY TWO PARAMETERS** that the **USER MUST SET**.
Tampering any other parameter shall generate wrong motion primitives. 

The details of the two parameters are as follows :

1. Path Distance
~~~~~~~~~~~~

The distance basically indicates the length  of the motion primitives from the center of the robot. The following diagram gives an illustration of the path distance.

.. image:: Images/maxl/robot_mprim.png
   :align: center

The path distance value shall remain within the following bounds : 
Minimum path distance : (Robot Length)/2 
Maximum path distance : obstacle horizon distance (shall be explained in section 4) 

2. Search radius 
~~~~~~~~~~~~~~~~~~

The search radius for the motion primitives shall be set a value equal to the radius of the circle that encircles the robot. The search radius parameter is illustrated in the following diagram. 

.. image:: Images/maxl/search_radius.png
   :align: center

Basically a higher search radius will provide a greater safety shield around the robot while the algorithm selects a path. However, a higher search radius will also lead to lesser free paths being available when the robot is confronted by an obstacle. 

Thus it would be wise and apt to set the search radius to a value = radius of the circle encircling the robot.


Hit the Submit button 
^^^^^^^^^^^^^^^^^^^^^^^^

.. image:: Images/maxl/submit_button.png
   :align: center

The motion primitives will begin generation and a progress bar is displayed to track it
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. image:: Images/maxl/progress.png
   :align: center

After completion
^^^^^^^^^^^^^^^^^
the web tool will display the motion primitives and will display the paths generated. Further the tool will prompt the user to enter the name for the paths that are generated


.. image:: Images/maxl/filename.png
   :align: center

A general convention to name the motion primitive file is given below

**mw_mprim_dxdd_rxrr**


d = path distance 
r = search radius

For example, the naming of the path file for motion primitives with path distance = 1.2 m and search radius = 0.55 m would be as follows :

mw_mprim_1x20_0x55

Another example, the naming of the path file for motion primitives with path distance = 0.75 m and search radius = 0.65 m would be as follows :

mw_mprim_0x75_0x65

Hit the download button
^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Uncompress the downloaded folder and place it in the active working directory in your robot workspace.


--------------------------------------------
Step 2 : Configuring the MaxL parameters
--------------------------------------------

The MaxL parameters are the parameters that help the algorithm decide what path to select during the robot motion when confronted by an obstacle and otherwise. There are four categories of MaxL parameters that the users can configure based on various condition. 

The parameters can be editted using the mw_maxl_planner.yml file which is located in the controller_config folder.


Parameters influneced by Bot architecture:
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
* **vehicleLength** : Specifies the robot length. Unit : m
* **vehicleWidth** : Specifies the robot width. Unit : m
* **maxSpeed** : Specifies the maximum speed the robot can operate at. Unit : m/s
* **maxAccel** : Specifies the maximum acceleration the robot can operate at. Unit : m/s\ :sup:`2`
* **min_lookahead** : Specifies the minimum lookahead point the robot must reach on the global path when the robot is in motion. Unit : m. Nominal value : (Robot length / 2) * 1.1 
* **in_place_rotation_penalty** : This parameter specifies the weight factor to be used while scoring the different free paths available when the robot is confronted by an obstacle. The following plot shows yaw angle Vs time, of a ROSbot when executing a 360\ :sup:`0` U-turn with various values of in_place_rotation_penalty
.. image:: Images/maxl/in_place_rotation_penalty_plot.png
   :align: center
   :width: 600



Parameters influneced by environment and trajectories:
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
* **pathFolder** : Specifies the path for the motion primitives folder where path files are located.
* **max_lookahead** : specifies the maximum lookahead point the robot must reach on the global path when the robot is in motion . Unit : m
* **max_yaw_rate** : Specifies speed at which the robot performs on spot turn. Unit : rad/s
* **yaw_gain** : Related to rotation of robot while in motion. Following plot shows performance of a ROSbot (time took to complete) on a given trajectory with different turn radii. 
.. image:: Images/maxl/yaw_gain.png
   :align: center
* **goal_direction_preference** : Weight factor to be used while scoring the different free paths available when the robot is confronted by an obstacle. In cluttered environment it is recommended to have lower values. Nominal value : 0.8
* **obstacle_horizon** : specifies the distance to which the robot must look inorder to detect an obstacle. Units : m Nominal value : 1.5 m. There is a constraint on this parameter as follows.It should be greater than path distance of the motion primitives.


Parameters For tuning Oscillations:
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
* **osc_det_by_path_index** :<value in boolean> if set true then oscillation detects by checking jump in the path, and below parameters are activated, if this parameter is false then below parameters have no effects.
   * **pi_osc_senstivity** : <value> controls the sensitivity of oscillation. If this value is high, even small jumps in chosen path will be considered an oscillation
   * **pi_osc_threshold** : <int value> Every Time an oscillation is detected, a count is increased, if this count goes above this threshold, oscillations are considered true and not just an error in detection
* **osc_det_by_angular_velocity** :<boolean> if true, oscillations will be detected by checking the frequency of change in ang_vel direction
   * **av_osc_sample_window** : <float> default value is  1.0 time period/window over which frequency of oscillation is calculated
   * **av_osc_freq_threshold** : <float value> if the frequency of change in oscillation magnitude per av_osc_sample_window is more than this value, it is considered an oscillation
* **pathFolder path for the set of path search config files**
   * For example shown below will find the the package called mw_mprims, navigates to path folder and parameters will be loaded from mw_mprims_1x0_0x9
   * **Note** : in the above file 1x0 is 1.0m path length and 0x9 is 0.9m search_radius from the center of the robot

   * **Note** : paths folder located in mw_mprims package


Adjusting motion of the robot:
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
* **Speed** : will take the value between 0 to 1, where 0 will stop the robot and 1 will be the maximum speed controller can provide.
* **Acceleration** : how quickly the robot will come into motion. Decreasing the value makes the robot smoother.. Can be adjusted as per the requirements 
   * **maxSpeed** : 1.5
   * **maxAccel** : 0.5
* **Look ahead point distance** : robot local vision area, in which robot keeps an eye for any obstacle in its path, this parameter needs to be tuned carefully as increasing this value may make the robot come very much near to the obstacle.
   * **lookahead_point_distance** : 0.4

* **Yaw_gain** : this gain helps the robot to rotate while the robot is in motion. 
* **Stop_yaw_gain** : yaw gain used when robot is stopped/almost stopped
* **Max_yaw_rate** : robot will make smoother rotation if value is lower and make faster turn if higher value. Takes the value between 0 to 1
   
   * **yaw_gain** : 1 # yaw gain used when robot is in motion
   * **stop_yaw_gain** : 0.6 # yaw gain used when robot is stopped/almost stopped
   * **max_yaw_rate** : 0.2 # maximum yaw rate for the robot

* **obstacle_horizon** : distance at which the robot will consider obstacle. For example 
   * **obstacle_horizon** : 2.0
In the above case if the object is within 2 m from the center of the robot then it will be considered as an obstacle.
* **reverse_enabled** : if set true robot will plan reverse direction, but goal should be within localcast rolling window area
   * **reverse_enabled** : false

Below image shown is local_costmap config file, so based on below setup, if reverse is enabled and if the goal is within 3m then robot plans reverse motion.

.. image:: Images/maxl/rolling_window.png
   :align: center



Users **should only** change the above mentioned parameters and **should not** change any other parameter values in the mw_maxl_planner.yml file