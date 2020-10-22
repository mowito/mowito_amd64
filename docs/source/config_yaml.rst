Config Paramaters
======================================

Mission Executive Config Parameters
----------------------------------------
Below is a brief of the parameters in the Mission Executive Config file.


**1. map_frame**

      This parameter stores the map frame id.

**2. robot_frame**

     This parameter stores the robot frame id.

**3. loop_frequency**

     The frequency at which the mission_executive node runs.

**4. max_time_lag**

     Maximum time in which the feedback should be recieved by the controller action server during the controlling state. 

**5. decay**

     The factor by which the velocity of the robot is decreased if the feedback lag from the controller action server passes the set threshhold (``max_time_lag``).

**6. planner**

     The planner name. User can chose between ``NavfnPlanner`` and ``genroute``

**7. controller**

     The controller name. User can chose between ``mw_maxl_planner``, ``trajectory_planner``, ``teb_local_planner`` and ``pure_pursuit_controller``

**8. plan_topic**

     The topic name at which the path consisting of waypoints is published.

**9. cmd_vel_topic**

     The topic name at which the command velocity of the robot is published.

**10. route_topic**

      The topic name at which the route markers for visualizing the route in Rviz are published.

**11. goal_queue_topic**

     The topic name at which the goal queue markers for vizualizing the goals in Rviz are published.

**12. tf_timeout**

     The time threshold in which the current robot pose should be updated.

**13. max_retries**

     The maximum amount of times the controller is allowed to reset before aborting the mission.

**14. min_distance_tolerance**

     If the robot traverses a distance lesser than the this tolerance for a time greater than the ``recovery_timeouts``, recovery will be triggered. The greater the value the more senstive the robot is to triggering recovery. 

**15. min_angular_tolerance**

     If the robot traverses an angular distance lesser than the this tolerance for a time greater than the ``recovery_timeouts``, recovery will be triggered. The greater the value the more senstive the robot is to triggering recovery. 

**16. controller_reset_timeout**

     The time threshold after which the controller is reset.

**17. recovery_timeouts i.e. recoveries**

     The timeouts for differnt types of recoveries are set in this field. The increasing order of timeouts decides the order in which recoveries will be executed. Recovery with the least timeout will be executed first and so on.

**18. goal_queue_mode**

     If ``true``, the executive will add new goals to a queue and pursue them on a one-by-one basis. If ``false``, the new goals will replace the old goal and only the latest goal will be pursued.