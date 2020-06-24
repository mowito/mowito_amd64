Tips
====
If you have any problems with laser scan it probably means that you don't have a dedicated graphic card (or lack appropriate drivers). If that's the case then you'll have to change couple of things in /rosbot_description/urdf/rosbot_gazebo file:

      Find::
      
         <!-- If you cant't use your GPU comment RpLidar using GPU and uncomment RpLidar using CPU gazebo plugin. -->
      
      next coment RpLidar using GPU using <!-- --> from <gazebo> to </gazebo> like below::

      
            <!-- gazebo reference="rplidar">
            <sensor type="gpu_ray" name="head_rplidar_sensor">
            <pose>0 0 0 0 0 0</pose>
            <visualize>false</visualize>
            <update_rate>40</update_rate>
            <ray>
                  <scan>
                  <horizontal>
                  <samples>720</samples>
                  <resolution>1</resolution>
                  <min_angle>-3.14159265</min_angle>
                  <max_angle>3.14159265</max_angle>
                  </horizontal>
                  </scan>
                  <range>
                  <min>0.2</min>
                  <max>30.0</max>
                  <resolution>0.01</resolution>
                  </range>
                  <noise>
                  <type>gaussian</type>
                  <mean>0.0</mean>
                  <stddev>0.01</stddev>
                  </noise>
            </ray>
            <plugin name="gazebo_ros_head_rplidar_controller" filename="libgazebo_ros_gpu_laser.so">
                  <topicName>/rosbot/laser/scan</topicName>
                  <frameName>rplidar</frameName>
            </plugin>
            </sensor>
            </gazebo -->


      Now uncomment RpLidar using CPU plugin removing <!-- -->.

      If you want to make your laser scan visible just change::

            <visualize>false</visualize>

      to::

            <visualize>true</visualize>

      in the same plug in.