.. _mission_executive:

======================================
Config : Mission Executive
======================================


Below is a brief of the parameters in the Mission Executive Config file.

+-----------------------------------+------------------------------------------------------------------------------------------+
| Parameter                         | Description                                                                              |
+-----------------------------------+------------------------------------------------------------------------------------------+
| map_frame                         | This parameter stores the map/global frame id.                                           |
+-----------------------------------+------------------------------------------------------------------------------------------+
| robot_frame                       | This parameter stores the robot frame id.                                                |
+-----------------------------------+------------------------------------------------------------------------------------------+
| loop_frequency                    | The frequency at which the mission_executive node runs.                                  |
+-----------------------------------+------------------------------------------------------------------------------------------+
| max_time_lag                      | Maximum time in which the feedback should be recieved by the controller action server    |
|                                   | during the controlling state.                                                            |
+-----------------------------------+------------------------------------------------------------------------------------------+
| decay                             | The factor by which the velocity of the robot is decreased if the feedback lag from the  |
|                                   | controller action server passes the set threshhold (``max_time_lag``).                   |
+-----------------------------------+------------------------------------------------------------------------------------------+
| planner                           | The planner name. User can chose between ``NavfnPlanner`` and ``genroute``.              |
+-----------------------------------+------------------------------------------------------------------------------------------+
| controller                        | The controller name. User can chose between ``mw_maxl_planner``,                         |
|                                   | ``trajectory_planner`` ( open source local planner).                                     |
+-----------------------------------+------------------------------------------------------------------------------------------+
| plan_topic                        | The topic name at which the path consisting of waypoints is published.                   |
+-----------------------------------+------------------------------------------------------------------------------------------+
| cmd_vel_topic                     | The topic name at which the command velocity of the robot is published.                  |
+-----------------------------------+------------------------------------------------------------------------------------------+
| route_topic                       | The topic name at which the route markers for visualizing the route in                   |
|                                   | Rviz are published.                                                                      |
+-----------------------------------+------------------------------------------------------------------------------------------+
| goal_queue_topic                  | The topic name at which the goal queue markers for vizualizing the goals                 |
|                                   | in Rviz are published.                                                                   |
+-----------------------------------+------------------------------------------------------------------------------------------+
| tf_timeout                        | The time threshold in which the current robot pose should be updated.                    |
+-----------------------------------+------------------------------------------------------------------------------------------+
| max_retries                       | The maximum amount of times the controller is allowed to reset before                    |
|                                   | aborting the mission.                                                                    |
+-----------------------------------+------------------------------------------------------------------------------------------+
| min_distance_tolerance            | If the robot traverses a distance lesser than the this tolerance for a                   |
|                                   | time greater than the ``recovery_timeouts``, recovery will be triggered.                 |
|                                   | The greater the value the more sensitive the robot is to triggering recovery.            |
+-----------------------------------+------------------------------------------------------------------------------------------+
| min_angular_tolerance             | If the robot traverses an angular distance lesser than the this tolerance                |
|                                   | for a time greater than the ``recovery_timeouts``, recovery will be triggered.           |
|                                   | The greater the value the more sensitive the robot is to triggering recovery.            |
+-----------------------------------+------------------------------------------------------------------------------------------+
| controller_reset_timeout          | The time threshold after which the controller is reset.                                  |
+-----------------------------------+------------------------------------------------------------------------------------------+
| recovery_timeouts i.e. recoveries | The timeouts for differnt types of recoveries are set in this field. The                 |
|                                   | increasing order of timeouts decides the order in which recoveries will be executed.     |
|                                   | Recovery with the least timeout will be executed first and so on.                        |
+-----------------------------------+------------------------------------------------------------------------------------------+
| goal_queue_mode                   | If ``true``, the executive will add new goals to a queue and pursue them                 |
|                                   | on a one-by-one basis. If ``false``, the new goals will replace the old goal             |
|                                   | and only the latest goal will be pursued.                                                |
+-----------------------------------+------------------------------------------------------------------------------------------+