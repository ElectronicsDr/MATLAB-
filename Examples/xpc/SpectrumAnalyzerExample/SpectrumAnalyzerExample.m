%% Spectrum Analyzer
%
% This example shows how to use Simulink(R) Real-Time(TM) as a real-time
% spectrum analyzer. The example uses the model |xpcdspspectrum|. To
% examine the design and implementation of the key block, 'Spectrum Scope',
% right-click the block and select 'Mask >> Look Under Mask'.
%
% The example displays the Fast Fourier Transform (FFT) of the input 
% signal using a buffer of 512 samples. The input signal is the sum of two 
% sine waves, one with an amplitude of 0.6 and a frequency of 250 Hz, the 
% other with an amplitude of 0.25 and a frequency of 600 Hz. The resulting 
% spectrum is displayed in a scope of type 'Target' on the target computer 
% monitor. 
%
% The example also shows how you can use MATLAB(R) language to change the 
% amplitude and frequency of the input sine waves while the application
% is running.
%
% To run the example, you must have installed DSP System Toolbox(TM) on 
% your development computer and started the target computer with target scopes 
% enabled.
%
%% Check Connection Between Development and Target Computers
% Use 'slrtpingtarget' to test the connection between the development and 
% target computers.
%
if ~strcmp(slrtpingtarget, 'success')
  error(message('xPCTarget:examples:Connection'));
end
%% Open, Build, and Download Model to the Target Computer
% Open the model |<matlab:open_system(fullfile(matlabroot,'toolbox','rtw','targets','xpc','xpcdemos','xpcdspspectrum')) xpcdspspectrum>|.  
% Under the model's configuration parameter Simulink Real-Time option settings, the
% system target file has been set to slrt.tlc. Hence, building the
% model will create an executable image, xpcdspspectrum.mldatx, that can be
% run on a computer booted with the Simulink Real-Time kernel.
open_system(fullfile(matlabroot,'toolbox','rtw','targets','xpc','xpcdemos','xpcdspspectrum'));

%%
% Build the model and download the image, xpcdspspectrum.mldatx, to the target computer.
%
% * Configure for a non-Verbose build.
% * Build and download application.
%
set_param('xpcdspspectrum','RTWVerbose','off'); 
rtwbuild('xpcdspspectrum');  
%% Run Model and Plot Spectrum Data
% Create the MATLAB(R) variable, tg, containing the Simulink Real-Time
% target object.  This object allows you to communicate with and control
% the target computer.  After starting the model, the spectrum will be
% displayed on the target computer screen.
%
% * Create an Simulink Real-Time Object
% * Start model execution
% * Wait for scope to be updated
% * Get spectrum plot
%
tg = slrt;                              
tg.start;                               
pause(1);                               
tg.viewTargetScreen;                    
tg.StopTime = 60;
disp('Note: Model will continue to run for 60 seconds. To stop execution, type tg.stop')
%% Changing Signal Characteristics
% You can change the amplitude and frequency of the sine wave generators 
% while the application is running. To do this, first call |getparamid| 
% with the target object, the block name, and the parameter name to get 
% the parameter object. Then, call |setparam| with the target object, the 
% parameter object, and the new value.
%
% |s1amp = getparamid(tg, 'Sine 1', 'Amplitude');|
%
% |setparam(tg, s1amp, 0.3);|
%
% By repeated use of the |getparamid| and |setparam| commands. you can
% monitor and vary the input signals in real time. 
%
% |s1fre = getparamid(tg, 'Sine 1', 'Frequency');|
%
% |setparam(tg, s1fre, 300);|
%
% |s2amp = getparamid(tg, 'Sine 2', 'Amplitude');|
%
% |setparam(tg, s2amp, 0.55);|
%
% |s2fre = getparamid(tg, 'Sine 2', 'Frequency');|
%
% |setparam(tg, s2fre, 500);|
%
% Copyright 2018 The MathWorks, Inc.
%
