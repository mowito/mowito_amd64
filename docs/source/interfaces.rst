Interfaces
======================================

Publishers
--------------------
Below is the list of publishers in the Mowito Navigation Stack.


**1. Command Velocity Publisher**

      The command velocity of the robot is published over the ``/cmd_vel`` topic by the command velocity publisher.

**2. Plan Publisher**

     The path consisting of waypoints is published over the ``/plan`` topic by the plan publisher.


**3. Route Marker Publisher**

     The route markers for visualizing the route in Rviz are published over the ``/route`` topic by the route marker publisher.

**4. Goal Queue Publisher**

      The goal queue publisher publishes over the ``/goal_queue`` topic for vizualizing the goal queue in Rviz.

**5. Mission Executive Status Publisher**

     The mission status of the robot  is published over the ``/mission_status`` topic by the mission executive status publisher.

Service Calls
---------------------
Here is a list of the service calls in the navigation stack.

**1. Set Plan**

      The ``/mission_executive/set_plan`` service allows the user to set a custom plan for the mission. This service could be used if the user wants to use thier own global planner to plan the path, and pass it to the navigation stack for the robot to follow it. one example of program using this service is set_plan_client.

**2. Set Route**

      The ``/mission_executive/set_route`` service allows the user to set multiple waypoints programatically. One example of a program using this service is set_route_client (checkout :ref:`route-based-navigation`). 

**3. Route Status**

      The ``/mission_executive/get_route_status`` service returns the status of current route the robot is executing.

**4. Change Planner**

      The ``/mission_executive/change_planner`` service changes the path planner used by the robot dynamically.

**5. Change Controller**

      The ``/mission_executive/change_controller`` service changes the controller used by the robot dynamically.

**6. Abort Planner Goals**

      The ``/mission_executive/abort_planner_goals`` service cancels all the planner goals.

**7. Abort Controller Goals**

      The ``/mission_executive/abort_controller_goals`` service cancels all the controller goals.

**8. Abort Mission**

      The ``/mission_executive/abort_mission`` service cancels all the planner and controller goals thereby aborting the mission.

**9. Trigger Recovery**

      The ``/mission_executive/trigger_recovery`` service triggers the robot into recovery mode.
