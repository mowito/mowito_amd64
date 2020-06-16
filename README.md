
# mowito

# Steps for runing robot using  Mowito’s Nav-stack (release 20.06.00)

## User Registration
Register yourself on this website <br>
https://mowito.in/register.html <br>
  

## setting up the mowito

1. Clone the repo in the home directory, using <br>

`git clone -b melodic https://github.com/mowito/mowito_amd64.git `<br>


2. Remove any previous installation of Mowito stack (replace 'melodic' with your ros version)<br>
`cd ~/mowito`<br>
`./remove_mowito.sh melodic`
 
3. Install the new Mowito stack<br>
`./setup_mowito.sh melodic`
	
## Running the Mowito Navigation Stack

## For Simulation

For Simulation, check ~/mowito/launch/simulation for the required launch files. The procedures and names are similar to the launch files for running on the real robot (mentioned below). 

## On Real Robot
### A. Running Navigation with no Map / Navigation to create Map

1. create a map using either of these three methods:<br><br>
1.1. **manual navigation**<br>
`source /opt/ros/melodic/setup.bash`<br>
`roslaunch ~/mowito/launch/run_mw_mapping.launch`<br><br>
in another terminal, start the remote control<br>
`rosrun teleop_twist_keyboard teleop_twist_keyboard`<br>
and use it move the robot around<br><br>
1.2. **Navigation, by giving goals through the rviz**<br>
`source /opt/ros/melodic/setup.bash`<br>
`roslaunch ~/mowito/launch/run_navigation_with_no_map.launch`<br><br>
in another terminal start rviz<br>
`source /opt/ros/melodic/setup.bash`<br>
`roslaunch ~/mowito/launch/start_rviz.launch`<br>
on rviz, give goals on the map, and the robot will move autnomously while creating the map<br><br>
1.3. **Autonomous goal selection ,throuh Exploration**<br>
`source /opt/ros/melodic/setup.bash`<br>
`roslaunch ~/mowito/launch/run_mw_mapping_with_explore.launch`<br><br>
in another terminal start rviz<br>
`source /opt/ros/melodic/setup.bash`<br>
`roslaunch ~/mowito/launch/start_rviz.launch`<br>
on rviz you can see the robot automatically moving and exploring the area<br>

2. Once you are done creating the map on rviz, save the map <br>
on a new terminal exeute the following <br>
`source /opt/ros/melodic/setup.bash`<br>
`cd && rosrun map_server map_saver -f mymap`<br>
the map (pgm and yaml) is saved  in the home directory with the name mymap.pgm and mymap.yaml<br><br>

### B. Running Navigation  with a pre-exitsting Map


1. Place the robot at the origin of map (the place where you started mapping)<br>
 
2. Now, for running the entire system with mowito’s controller run<br>  
`source /opt/ros/melodic/setup.bash`<br>
`roslaunch ~/mowito/launch/run_mw_navigation.launch map_name:=mymap`<br>

5. in another terminal start rviz<br>
`source /opt/ros/melodic/setup.bash`<br>
`roslaunch ~/mowito/launch/start_rviz.launch`<br>

6. in the rviz, click on the second top panel, click on the nav goal option, and click on the displayed map to give goal to the robot<br>

7. look at the output on the rviz, the path planned and the motion of the robot.<br>
