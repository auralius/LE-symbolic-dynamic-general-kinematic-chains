# Dynamic equation with Lagrange for a general kinematic chain defined by sets of DH parameters. 

Simple and straight-forward implementation of DH-parameters in MATLAB  
This can be used to execute forward kinematics of the robot to find position and orientation of every link of the robot.  

Features:
* Kinematics
  * Forward kinematics
  * Homogenous transformation of each link of the robot
  * Numerical jacobian
* Forward dynamics
* Simple visualization, it can also be animated

![Screenshot][sshot]

[sshot]: https://raw.githubusercontent.com/auralius/matlab-dh-parameters/master/sshot.png "Screenshot"

Auralius Manurung 
manurung.auralius@gmail.com

Notes:  
All position coordinates, mass matrix M. and generalized forces u are in column vector (n x 1)!  
Example: for a 3-DOF robot, M = [1; 1; 1], x0 = [0; 0; 0; 0; 0; 0] and so on and so forth.  

Main references:  
http://youngmok.com/lagrange-equation-by-matlab-with-examples/

