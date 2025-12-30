% Copyright (C) 2012 Quan Wang <wangq10@rpi.edu>,
% Signal Analysis and Machine Perception Laboratory,
% Department of Electrical, Computer, and Systems Engineering,
% Rensselaer Polytechnic Institute, Troy, NY 12180, USA

% This package implements the Gradient Vector Flow (GVF) in C++/MEX, which
% is significantly faster than the Matlab implementation.
% Please run this script as a simple demo.

% This implementation is used by the following paper:
% Quan Wang, Kim L. Boyer,
% The active geometric shape model: A new robust deformable shape model and its applications,
% Computer Vision and Image Understanding, Volume 116, Issue 12, December 2012, Pages 1178-1194,
% ISSN 1077-3142, https://doi.org/10.1016/j.cviu.2012.08.004

clear; clc; close all;

% Load Octave image package if needed
if exist('OCTAVE_VERSION', 'builtin')
    pkg load image;
end

%% Compile
if exist('GVF', 'file') ~= 3 % Check if MEX file exists (3 is MEX file)
    disp('Compiling GVF.cpp...');
    try
        mex GVF.cpp;
        disp('Compilation successful.');
    catch ME
        error('Compilation failed: %s', ME.message);
    end
else
    disp('GVF already compiled.');
end

%% Load Image
filename = 'image.png';
if ~exist(filename, 'file')
    error('Image file %s not found.', filename);
end
I0 = imread(filename);
if size(I0, 3) == 3
    I0 = rgb2gray(I0);
end
I = double(I0);

%% Blur Image
s = 5; % Sigma
I = gaussianBlur(I, s);

%% Parameters
alpha = 0.2;
mu = 0.2;
iter = 20;

%% Run GVF
fprintf('Running GVF...\n');
tic;
[u, v] = GVF(I, alpha, mu, iter);
t = toc;

fprintf('Computing GVF used %f seconds.\n', t);

%% Visualize Result
figure;
imshow(I0, []);
hold on;
% Downsample for better visualization if image is large
step = 1; 
quiver(u(1:step:end, 1:step:end), v(1:step:end, 1:step:end));
axis ij off;
title('Gradient Vector Flow');
hold off;

