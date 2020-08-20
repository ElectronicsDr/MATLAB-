%% Four Hydraulic Cylinder Simulation
% 
% This example shows how to use Simulink(R) to create a model with four 
% hydraulic cylinders. See two related examples that use the same basic components:
% <matlab:cd(setupExample('simulink_general/sldemo_hydcyl4Example'));open_system('sldemo_hydcyl') single cylinder model> and
% <matlab:cd(setupExample('simulink_general/sldemo_hydcyl4Example'));open_system('sldemo_hydrod') model with two cylinders and load
% constraints>.
%
% * Note: This is a basic hydraulics example. You can more easily build hydraulic
% and automotive models using Simscape(TM) Driveline(TM) and Simscape Fluids(TM).
%
% * *Simscape Fluids* provides component libraries for modeling and simulating
% fluid systems. It includes models of pumps, valves, actuators, pipelines, and
% heat exchangers. You can use these components to develop fluid power systems
% such as front-loader, power steering, and landing gear actuation systems. Engine
% cooling and fuel supply systems can also be developed with Simscape Fluids. You
% can integrate mechanical, electrical, thermal, and other systems using
% components available within the Simscape product family.
%
% * *Simscape Driveline* provides component libraries for modeling and simulating
% one-dimensional mechanical systems. It includes models of rotational and
% translational components, such as worm gears, planetary gears, lead screws, and
% clutches. You can use these components to model the transmission of mechanical
% power in helicopter drivetrains, industrial machinery, vehicle powertrains, and
% other applications. Automotive components, such as engines, tires,
% transmissions, and torque converters, are also included.

% Copyright 2006-2015 The MathWorks, Inc.

%% Modeling
%
% Figure 1 shows the top level diagram of the model. This model has a single
% pump and four actuators. The same pump pressure (|p1|) drives each cylinder
% assembly and the sum of their flows loads the pump. Although each of the four
% control valves could be controlled independently, as in an active suspension
% system, in this case all four receive the same commands, a linear ramp in
% orifice area from zero to |0.002 sq.m.|.
%

%% Opening the Model and Running the Simulation 
%
% To <matlab:openExample('simulink_general/sldemo_hydcyl4Example') open this model>, type
% |sldemo_hydcyl4| at MATLAB(R) terminal (click on the hyperlink if you are
% using MATLAB Help). Press the "Play" button on the model toolbar to run
% the simulation. 
%
% * Note: The model logs relevant data to MATLAB workspace in a structure
% called |sldemo_hydcyl4_output|. Logged signals have a blue indicator
% (<matlab:openExample('simulink_general/sldemo_hydcyl4Example') see 
% the model>). Read more about Signal Logging in Simulink Help.    

open_system('sldemo_hydcyl4');     % hidden code, not displayed in HTML example page
evalc('sim(''sldemo_hydcyl4'')');  % run simulation, don't display output

%% 
% *Figure 1:* Four cylinder model and simulation results

%% Model Description
%
% The pump flow begins at |0.005 m3/sec| (just like in the single cylinder model),
% then it drops to |0.0025 m3/sec| at |t=0.05 sec|. The parameters |C1|, |C2|, |Cd|, |rho|,
% and |V30| are identical to those in the
% <matlab:cd(setupExample('simulink_general/sldemo_hydcyl4Example'));open_system('sldemo_hydcyl') single cylinder model>.   
% However, by assuming individual values for |K|, |A|, and |beta|,
% each one of the four cylinders exhibit distinctive transient responses. The
% table below gives the characteristics of the four actuators.

%%
%   ----------------------------------------------------------------
%   Parameter       |  Actuator1   Actuator2   Actuator3   Actuator4
%   ----------------|-----------------------------------------------
%   Spring Constant |  K           K/4         4K          K
%   Piston Area     |  Ac          Ac/4        4Ac         Ac
%   Bulk Modulus    |  Beta        Beta        Beta        Beta/1000
%   ----------------------------------------------------------------
%   Beta = 7e8  Pa  [fluid bulk modulus] 
%   K    = 5e4  N/m [spring constant]
%   Ac   = 1e-3 m^2 [cylinder cross-sectional area]

%%
% The ratio of area and spring constant is the same for all pistons, so
% they should have the same steady state output. The dominant time constant
% for each actuator subsystem is proportional to
%
% $$\frac{A_c^2}{K}$$
%
% (result obtained from dimensional analysis), so we can expect the piston assembly 2 to be
% somewhat faster than assembly 1. The piston assembly 3 is expected to be
% slower than 1 or 2. The piston assembly 4 has a significantly lower bulk
% modulus beta (as would be the case with air), thus we expect piston 4 to
% respond more sluggishly than piston 1.

%% Results
%

% plot piston positions, code hidden
plot(sldemo_hydcyl4_output.get('Positions').Values.x1.Time, ...
     sldemo_hydcyl4_output.get('Positions').Values.x1.Data, 'w', ...
     sldemo_hydcyl4_output.get('Positions').Values.x2.Time, ...
     sldemo_hydcyl4_output.get('Positions').Values.x2.Data, 'r', ...
     sldemo_hydcyl4_output.get('Positions').Values.x3.Time, ...
     sldemo_hydcyl4_output.get('Positions').Values.x3.Data, 'g', ...
     sldemo_hydcyl4_output.get('Positions').Values.x4.Time, ...
     sldemo_hydcyl4_output.get('Positions').Values.x4.Data, 'b');
set(gca,'Color','k','XGrid','On','XColor',[0.3 0.3 0.3],...
                    'YGrid','On','YColor',[0.3 0.3 0.3]);
h = legend('x_1','x_2','x_3','x_4','Location','best');
set(h,'TextColor','w','Color','none'); clear h;
xlabel('Time (sec)');
ylabel('Piston Position (m)');
title('Simulation Results: Piston Positions');

%%
% *Figure 2:* Piston positions in four cylinder example


% Plot the pressures, hidden code
plot(sldemo_hydcyl4_output.get('SupplyPressure').Values.Time, ...
     sldemo_hydcyl4_output.get('SupplyPressure').Values.Data,'g');
set(gca,'Color','k','XGrid','On','XColor',[0.3 0.3 0.3],...
                    'YGrid','On','YColor',[0.3 0.3 0.3]);
xlabel('Time (sec)');
ylabel('Pump Pressure p_1 (Pa)');
title('Pump Supply pressure');
%%
%
% *Figure 3:* Pump Supply Pressure, |p1|

%%
%
% The initial jolt of flow at |t=0| is seen by the four actuators as a pressure
% impulse. The pump pressure (|p1|), which is initially high, drops rapidly because
% there is a high flow demand from the four loads. During the initial transient
% (about |4 msec|), distinct responses identify the individual dynamic
% characteristics of each assembly unit.
%
% As predicted by the parameter values, actuator 2 responds much faster than
% actuator 1. The third and fourth pistons are much slower because they require
% more working fluid to move the same distance.  In case 3, the piston displaces
% more volume due to its larger cross-sectional area. In case 4, although the
% displaced volume is the same as in case 1, the device requires more fluid
% because it is subsequently compressed.
%
% As the pump pressure falls to the level within the cylinders, the distinctions
% in behavior are blurred. The individual responses blend into an overall system
% response which maintains the flow balance between the components. At |t=0.05
% sec|, the pump flow drops to a level that is close to the equilibrium and the
% actuator flows are nearly zero. The individual steady state piston positions
% are equal, as predicted by the design.

%% Closing the Model
%
% Close the model. Clear generated data.
close_system('sldemo_hydcyl4', 0);
clear sldemo_hydcyl4_output;
 