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

% %%%% c: %%%%
r = 8   *(10^-2); % m
d = 17  *(10^-2); % m
l = 25.5*(10^-2); % m

% %%%% d: %%%%
data_folder = 'Locomotive Testing Data';
files    = dir([data_folder, '/', '*V']); % regex. Learn it.
numfiles = size(files, 1);

% %%%% e: %%%%
results = {}; % for storing results
for i = 1:numfiles                                % each file
  filepath   = [data_folder, '/', files(i).name]; % get name
  data       = load_file(filepath);               % load it
  results{i} = analyze(data);                     % analyze and store
end

figure; hold on;
for i = 1:numfiles % plot each result
  data = results{i};
  scatter(data(:, 1), data(:, 2), '.');
end
xlabel('Wheel rotation [^\circ degrees]');
ylabel('Slide speed [mm/s]');
title('Slide Speed vs Wheel Position');
