function GI = gaussianBlur(I, s)
%GAUSSIANBLUR Perform Gaussian blur on an image.
%   GI = GAUSSIANBLUR(I, s) filters the input image I with a Gaussian 
%   filter with standard deviation s.
%   
%   Inputs:
%       I - Input image (double or uint8).
%       s - Standard deviation (sigma) of the Gaussian distribution.
%
%   Outputs:
%       GI - Blurred image.
%
%   Copyright (C) 2012 Quan Wang <wangq10@rpi.edu>
%   Signal Analysis and Machine Perception Laboratory
%   Department of Electrical, Computer, and Systems Engineering
%   Rensselaer Polytechnic Institute, Troy, NY 12180, USA

    % Input validation
    if nargin < 2
        error('Not enough input arguments. Usage: GI = gaussianBlur(I, s)');
    end

    % Define the filter size based on sigma
    % Typically, a kernel width of 3*sigma covers 99.7% of the distribution.
    h = fspecial('gaussian', ceil(s)*3+1, s);

    % Convolve the image with the filter, handling boundaries by replicating
    GI = imfilter(I, h, 'replicate');
end
