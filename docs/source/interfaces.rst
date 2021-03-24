Interfaces
======================================

ROS-Topics
^^^^^^^^^^^^^^
Below is the list of ROStopics in the Mowito Navigation Stack. In order to check the data from any of the topics below, on terminal
1. source ROS ``source /opt/ros/<your ros version>/setup.bash``
2. ``rostopic echo <ros topic name>``

+------------------------------------+---------------------+-------------------------------------------------------------------------------------+
| Topic name                         | address             | description                                                                         |
+------------------------------------+---------------------+-------------------------------------------------------------------------------------+
| Command Velocity Publisher         | ``/cmd_vel``        | it contains the linear and angular velocity which the robot should follow.          |
+------------------------------------+---------------------+-------------------------------------------------------------------------------------+
| Plan Publisher                     | ``/plan``           | it contains the global path/plan which the robot will follow                        |
+------------------------------------+---------------------+-------------------------------------------------------------------------------------+
| Goal Queue Publisher               | ``/goal_queue``     | Publishes all the goals in the queue                                                |
+------------------------------------+---------------------+-------------------------------------------------------------------------------------+
| Odometry                           | ``/odom``           | Contains the odometry of the robot. It is used as **input** by the Navigation Stack |
+------------------------------------+---------------------+-------------------------------------------------------------------------------------+
| Mission Executive Status Publisher | ``/mission_status`` | Contains the navigation status of the robot.                                        |
+------------------------------------+---------------------+-------------------------------------------------------------------------------------+

Service Calls
^^^^^^^^^^^^^^^

In order to make a service call, on terminal (after sourcing ROS) do ``rosservice call <address of the service> <tab><tab>`` . Tab-tab to autocomplete the data structure, which user can modify. Service calls are best done programmatically, rather than through terminal. Here is a list of the service calls in the navigation stack.

+-----------------------+-----------------------------------------------+-------------------------------------------------------------------------------------------------+
| Service Name          | Address                                       | Description                                                                                     |
+-----------------------+-----------------------------------------------+-------------------------------------------------------------------------------------------------+
| Set Plan              | ``/mission_executive/set_plan``               | It lets the user to set a custom plan for the mission.                                          |
|                       |                                               | In other words, this service is used to when custom global planner is used                      |
|                       |                                               | to plan the path, and pass it to the navigation stack for the robot to follow it.               |
|                       |                                               | one example of program using this service is ``rosrun mission_executive set_plan_client``       |
+-----------------------+-----------------------------------------------+-------------------------------------------------------------------------------------------------+
| Set Route             | ``/mission_executive/set_route``              | It lets the user to set multiple waypoints programatically. One example of a                    |
|                       |                                               | program using this service is ``set_route_client`` (checkout Route based Navigation in Step 4). |
+-----------------------+-----------------------------------------------+-------------------------------------------------------------------------------------------------+
| Route Status          | ``/mission_executive/get_route_status``       | returns the status of current route the robot is executing                                      |
+-----------------------+-----------------------------------------------+-------------------------------------------------------------------------------------------------+
| Change Planner        | ``/mission_executive/change_planner``         | changes the path planner used by the robot dynamically ( without terminating the stack).        |
+-----------------------+-----------------------------------------------+-------------------------------------------------------------------------------------------------+
| Change Controller     | ``/mission_executive/change_controller``      | changes the controller used by the robot dynamically                                            |
+-----------------------+-----------------------------------------------+-------------------------------------------------------------------------------------------------+
| Abort Planner Goals   | ``/mission_executive/abort_controller_goals`` | cancels all the controller goals                                                                |
+-----------------------+-----------------------------------------------+-------------------------------------------------------------------------------------------------+
| Abort Mission         | ``/mission_executive/abort_mission``          | cancels all the planner and controller goals thereby aborting the mission                       |
+-----------------------+-----------------------------------------------+-------------------------------------------------------------------------------------------------+
| Abort Controller Goal | ``/mission_executive/abort_controller_goals`` | cancels all the controller goals.                                                               |
+-----------------------+-----------------------------------------------+-------------------------------------------------------------------------------------------------+
| Trigger Recovery      | ``/mission_executive/trigger_recovery``       | triggers the robot into recovery mode                                                           |
+-----------------------+-----------------------------------------------+-------------------------------------------------------------------------------------------------+