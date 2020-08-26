Interfaces
======================================

Publishers
--------------------
Below is the list of publishers in the Mowito Navigation Stack.


**1. Command Velocity Publisher**

      The ``cmd_vel_pub_`` publishes the command velocity of the robot over the **/cmd_vel** topic.

**2. Plan Publisher**

      The ``plan_pub_`` publishes the path consisting of waypoints over the **/plan** topic.

**3. Route Marker Publisher**

      The ``route_marker_pub_`` publishes the route markers for visualizing the route in Rviz over the **/route** topic.

**4. Goal Queue Publisher**

      The ``goal_queue_pub_`` publishes over the **/goal_queue** topic for vizualizing the goal queue in Rviz.

**5. Mission Executive Status Publisher**

      The ``mission_executive_status_pub_`` publishes the mission status of the robot over the **/mission_status** topic.

Service Calls
---------------------
Here is a list of the service calls in the navigation stack.

**1. Set Plan**

      The ``set_plan`` service sets the type of planner the robot will use.

**2. Set Route**

      The ``set_route`` service allows the user to set a predefined route comprised of waypoints from a .yaml file.

**3. Route Status**

      The ``route_status`` service returns the status of current route the robot is executing.

**4. Change Planner**

      The ``change_planner`` service changes the path planner used by the robot dynamically.

**5. Change Controller**

      The ``change_controller`` service changes the controller used by the robot dynamically.

**6. Abort Planner Goals**

      The ``abort_planner_goals`` service cancels all the planner goals.

**7. Abort Controller Goals**

      The ``abort_controller_goals`` service cancels all the controller goals.

**8. Abort Mission**

      The ``abort_mission`` service cancels all the planner and controller goals thereby aborting the mission.

**9. Trigger Recovery**

      The ``trigger_recovery`` service triggers the robot into recovery mode.
