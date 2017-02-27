% Write a MATLAB main script (lab3.m) that does the following:
% a.   Gives the purpose of the script, names of all the people in the group, date
% b.   Closes all figures and clears all variables
% c.   Sets values for r, d, l, and any constants you need for conversions
% d.   Chooses the data files to be analyzed
% e.   In a loop, calls a function to analyze the data (analyze.m)
% In aw, and sets up an angle input from 0 to 6 revolutions. Call the model function from your script and
% plot the returned model velocity (in cm/s) as a function of theta (in degrees).
% Explain how you checked that it is working correctly.

% %%%% META %%%%
% @PARAMS   => none - script.
% @RETURNS  => none - script.
% @DISPLAYS => 1 graph

% %%%% a: %%%%
% - PURPOSE -
% This is the main MATLAB script for Lab 3 of ASEN 2003. Its does the work of identifying files,
% passing them to the `analyze` function, and plotting results.
% - NAMES -
% Jacob Killelea
% Jeffrey Mariner Gonzalez
% Matthew Jonas

% %%%% b: %%%%
clear all; close all; clc;
outfile = fopen('output_table.txt', 'w'); % empty contents of file
fclose(outfile);

% %%%% c: %%%%
r = 8   ; % cm                                  * (10^-2); % m
d = 17  ; % cm                                  * (10^-2); % m
l = 25.5; % cm                                  * (10^-2); % m

% %%%% d: %%%%
data_folder = '../locomotive-data';
files       = dir([data_folder '/' '*V']); % regex. Learn it.
numfiles    = size(files, 1);

% %%%% e: %%%%
results = {}; % for storing results
for i = 1:numfiles                                     % each file
  filepath        = [data_folder, '/', files(i).name]; % get name
  data            = load_file(filepath);               % load it
  data.trialname = [files(i).name(1), files(i).name((end-2):end)]; % get the first char and last 3 chars to keep track of the origin of the data
  results{i}      = analyze(data); % analyze and store
end

for i = 1:numfiles % plot each result
  data = results{i};

  model_speed = vB(data.wheel_speed, data.pos);

  model_err   = model_speed - data.speed;
  mean_err    = mean(model_err);
  std_err     = std(model_err);

  % a.   subplot(2,2,1) Show observed angular velocity on the y-axis (rad/sec) and theta (degrees) on the x-axis.
  figure; hold on;
  subplot(2, 2, 1);
  plot(data.pos, (data.wheel_speed).*(pi/180));
  title(sprintf('Angular Velocity vs Theta (%s)', data.trialname));
  xlabel('Theta [^\circ degrees]');
  ylabel('Omega [radians / sec]');

  % b.   subplot(2,2,2) Show observed and modeled collar velocity using units of cm/sec. x-axis should be in theta in degrees. Use a legend.  
  subplot(2, 2, 2);
  hold on;
  plot(data.pos, data.speed,       'DisplayName', 'Data'); % data velocity
  plot(data.pos, model_speed, '-', 'DisplayName', 'Model'); % model velocity
  title('Velocities of Model and Data vs Theta');
  xlabel('Wheel rotation [^\circ degrees]');
  ylabel('Slide speed [cm/s]');
  legend('show');

  % c.   subplot(2,2,3) Show the residual collar velocity, i.e. observed collar velocity minus the modeled collar velocity (in cm/sec). x-axis should be theta in degrees.  
  subplot(2, 2, 3);
  plot(data.pos, model_err);
  title('Difference Between Model and Data');
  xlabel('Wheel rotation [^\circ degrees]');
  ylabel('Slide speed [cm/s]');

  % d.   subplot(2,2,4) Make a histogram (Matlab function histfit) of the residuals using 20 bins.  
  subplot(2, 2, 4);
  histfit(model_err, 20);
  title('Histogram of Error')

  print(data.trialname, '-djpeg', '-noui')

  %   Summarize your results in a table generated in MATLAB. Make it clear which are the class datasets and which
  % datasets you collected.
  % Include:
    % a.   the standard deviation of the residuals for collar velocity (which I will call sigma here)
    % b.   the mean of the residuals
    % c.   the uncertainty of the mean residual (sigma divided by square root of the number of residuals)
    % d.   the number of observations
    % e.   the number of residuals that are greater than 3 sigma
    % disp(data.trialname);
  outfile = fopen('output_table.txt', 'a');
  fprintf(outfile, '%s', data.trialname);
  fprintf(outfile, '| StdDev: %8.4f |',          std_err);
  fprintf(outfile, '| MeanResids: %8.4f |',      mean_err);
  fprintf(outfile, '| UncMeanResids: %8.4f |',   (std_err./sqrt(size(model_err))));
  fprintf(outfile, '| NumObs: %3d |',            length(model_err));
  fprintf(outfile, '| #Resids > 3 sigma: %d |',  sum(model_err > 3*std_err));
  fprintf(outfile, '\n');
  fclose(outfile);
end

pause
close all
