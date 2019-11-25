# F-16-Longitudinal
Linearization and nonlinear simulation of unstable F-16 Aircraft.

The equations of motion for longitudinal aircraft dynamics are obtained
Then, a nonlinear simulation is developed using Simulink Lookup Tables
Next, a linearized model is developed and stability derivatves are calculated with Simulink
Finally, a PID MIMO State Space model is developed to maintain a steady glide path and speed for landing at an airport
The landing simulation is performed at YUL - Montreal Trudeau

The F-16 Aerodynamic Data is obtained from:
https://dept.aem.umn.edu/~balas/darpa_sec/SEC.Accom.html

The nonlinear and linear simulation are seperate simulations

For the nonlinear model:
1) Run constants.m first
2) Then run nonlinear_sim OR nonlinear_sim_FG, (if you have FlightGear)
3) Note, if you do not have a joystick, just remove the model block

For the linear model:
1) Run controller_design.m first
2) Then run CONTROLLER_LONG or CONTROLLER_LONG_FG (if you have FlightGear)


