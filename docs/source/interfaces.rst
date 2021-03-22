Interfaces
======================================

Publishers
^^^^^^^^^^^^^^
Below is the list of publishers in the Mowito Navigation Stack.

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

Here is a list of the service calls in the navigation stack.

**1. Set Plan**
~~~~~~~~~~~~~~~~~~

      The ``/mission_executive/set_plan`` service allows the user to set a custom plan for the mission. This service could be used if the user wants to use thier own global planner to plan the path, and pass it to the navigation stack for the robot to follow it. one example of program using this service is set_plan_client.

**2. Set Route**
~~~~~~~~~~~~~~~~~~

      The ``/mission_executive/set_route`` service allows the user to set multiple waypoints programatically. One example of a program using this service is set_route_client (checkout Route based Navigation in Step 4). 

**3. Route Status**
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

      The ``/mission_executive/get_route_status`` service returns the status of current route the robot is executing.

**4. Change Planner**
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

      The ``/mission_executive/change_planner`` service changes the path planner used by the robot dynamically.

**5. Change Controller**
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

      The ``/mission_executive/change_controller`` service changes the controller used by the robot dynamically.

**6. Abort Planner Goals**
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

      The ``/mission_executive/abort_planner_goals`` service cancels all the planner goals.

**7. Abort Controller Goals**
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

      The ``/mission_executive/abort_controller_goals`` service cancels all the controller goals.

**8. Abort Mission**
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

      The ``/mission_executive/abort_mission`` service cancels all the planner and controller goals thereby aborting the mission.

**9. Trigger Recovery**
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

      The ``/mission_executive/trigger_recovery`` service triggers the robot into recovery mode.