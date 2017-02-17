% Write a MATLAB main script (lab3.m) that does the following:
% a.   Gives the purpose of the script, names of all the people in the group, date
% b.   Closes all figures and clears all variables
% c.   Sets values for r, d, l, and any constants you need for conversions
% d.   Chooses the data files to be analyzed
% e.   In a loop, calls a function to analyze the data (analyze.m)
% In aw, and sets up an angle input from 0 to 6 revolutions. Call the model function from your script and
% plot the returned model velocity (in cm/s) as a function of theta (in degrees).
% Explain how you checked that it is working correctly.

% %%%% a: NAMES %%%%
% Jacob Killelea
% Jeffrey Mariner Gonzalez
% Matthew Jonas
% %%%% b: %%%%
  clear all; close all; clc;
  data_folder = 'Locomotive Testing Data';
% %%%% c: %%%%
  % r = ;
  % d = ;
  % l = ;
  % error('r, d, and l not set!');
% %%%% d: %%%%
  files = dir([data_folder, '/', '*V'])
  numfiles = size(files, 1);
% %%%% e: %%%%

for i = 1:numfiles
  filepath = [data_folder, '/', files(i).name];
  data     = load_file(filepath)
end
