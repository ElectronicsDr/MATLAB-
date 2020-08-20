%% Data Analysis App in App Designer
% This app shows how to define two tabs to list and plot data. 
% One tab contains a chart and a few user interface components for adjusting the chart. 
% The other tab displays a table that lists the data used to make the chart. 
% The app includes these components:
% 
% * Check boxes &mdash; used to update the plot with male or female 
% data when the user toggles a check box.
% * Switch &mdash; used to switch between visualizing systolic and diastolic data.
% * Button group containing radio buttons &mdash; used to manage exclusive 
% selection of radio buttons. When the user selects a radio button, the button 
% group executes a callback function to update the plot with the appropriate data.
% * Slider &mdash; used to adjust histogram bin width. This slider only appears when the 
%  *Histogram* plotting option is selected in the button group.
% * Table &mdash; used to view the data associated with the chart.
% 
% <<../patientsdisplay_screenshot_17a.png>>  

% Copyright 2015 The MathWorks, Inc.