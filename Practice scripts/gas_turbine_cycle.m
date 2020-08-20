clear all
clc
Work_done_gas=8000000;
p1=10000; %Low Pressure turbine in kPa as per design specifications
t1=310; %Temperature 1. 
h1 = 310.45; %Using the Gas Properties table(attached)
% Calculating the second enthalpy change using the Pump work done
v1=0.00101; %Using the specific volume of H20 =0.00101m3/kg
p2=12500000; % Pressure used tho heat steam as per design specifications

h2=h1+v1*(p2-p1);
wp1=v1*(p2-p1); % work done by the pump
t3=500;%Temperature the heat exchanger reaches when heating steam in degrees
h3=1221.4; %Enthalpy 3 for t3 using the Gas properties table (attached)
p3=12500000; %Pressure at state 3 from the design specifications
%Equivalent entropy values for the two processes is
s3=6.665; % Equivalent for state process 3 and 4

p4=2500000; %High Pressure Turbine values.
h4=401.3; % Corresponding enthalpy from the properties table

t5=823; %Temperature corresponding to 550 degrees
h5=844.3; %Corresponding enthalpy.
p5=12500000; %Pressure leaving the heat exchanger.
% using the relation that entropy at 5 is equal to entropy at 7
%which is equal to 7.470kJ/kgK
p6=10000; %Using the relation above
h6=721; %Corresponding value from the gas properties table

t7=310;
h7=510.24;
ratio= 1400/400;
pr7=1.6423;
pradntl_number8=ratio*pr7;
h8=431.24; % Enthalpy at state 8
t9=1400; %Temperature going into the turbine as per design specifications
h9=853.36; %Corresponding enthalpy at state 9
pr9=431.5;
prandtl_number10=ratio*pr9;
h10=841; %Corresponding enthalpy for state 10
t11= 520; %Temperature of combustion gases leaving heat exchanger
h11=524.0; %Corresponding enthalpy
work_turbine=(h9 -h10);
work_compressor =(h7- h8);
%================================Computations===============================
enthalpy_change=h3-h2;
Mass_flowRate_air= Work_done_gas/(work_turbine+work_compressor);
total_heat_rate_input=Mass_flowRate_air*(h9-h8)+12*(h5-h4);
total_heat_rejected=Mass_flowRate_air*(h11-h7)+12*(h6-h1);
thermal_efficiency=(1-(total_heat_rejected/total_heat_rate_input))*100;
Mass_flow_rate = sprintf('The mass flow rate of air into the gas-turbine cycle is: \n %d kg/s \n',round(Mass_flowRate_air));
Heat_Input= sprintf('The rate of total heat input into the combustion chamber is: \n %d W \n',round(total_heat_rate_input));
Thermal_Efficiency = sprintf('The thermal efficiency of the combined cycle is: \n % 1f%% \n',thermal_efficiency);
disp(Mass_flow_rate);
disp(Heat_Input);
disp(Thermal_Efficiency)