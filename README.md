# Fast Gradient Vector Flow

[![View Fast Gradient Vector Flow (GVF) on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/45896-fast-gradient-vector-flow-gvf)
[![Octave application](https://github.com/wq2012/Fast-Gradient-Vector-Flow/actions/workflows/octave.yml/badge.svg)](https://github.com/wq2012/Fast-Gradient-Vector-Flow/actions/workflows/octave.yml)

This package implements the **Gradient Vector Flow (GVF)** algorithm in C++/MEX, offering significantly faster performance compared to standard MATLAB implementations.

## Table of Contents
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Citation](#citation)
- [License](#license)

## Features
- **High Performance**: C++ implementation integrated with MATLAB/Octave via MEX.
- **Robustness**: Effective for deformable shape models and image segmentation tasks.
- **Ease of Use**: Simple interface with demo script included.

## Prerequisites
- **MATLAB** or **GNU Octave**.
- A C++ compiler configured for MEX (e.g., `gcc`, `clang`, or MSVC).

## Installation
1. Clone or download this repository.
2. Navigate to the repository folder in MATLAB/Octave.
3. Run the demo script to automatically compile the MEX file:
   ```matlab
   run_demo
   ```
   Or compile manually:
   ```matlab
   mex GVF.cpp
   ```

## Usage
The main function is `GVF`. 

### Syntax
```matlab
[u, v] = GVF(f, alpha, mu, iter);
```

### Arguments
- **Inputs**:
  - `f`: 2D energy field (or gradient field).
  - `alpha`: Step size of the update (0 < alpha < 1).
  - `mu`: GVF regularization coefficient.
  - `iter`: Number of iterations.

- **Outputs**:
  - `u`: Resulting GVF component in the x-direction.
  - `v`: Resulting GVF component in the y-direction.

### Example
```matlab
% Load and preprocess image
I = double(imread('image.png'));
I = gaussianBlur(I, 5); % Optional blur

% Compute GVF
[u, v] = GVF(I, 0.2, 0.2, 20);

% Visualize
quiver(u, v);
axis ij off;
```

## Citation
If you use this code in your research, please cite the following paper:

> Quan Wang, Kim L. Boyer, "The active geometric shape model: A new robust deformable shape model and its applications", Computer Vision and Image Understanding, Volume 116, Issue 12, December 2012, Pages 1178-1194, ISSN 1077-3142, https://doi.org/10.1016/j.cviu.2012.08.004.

