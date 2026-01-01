# Fast Gradient Vector Flow

[![View Fast Gradient Vector Flow (GVF) on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/45896-fast-gradient-vector-flow-gvf)
[![Octave application](https://github.com/wq2012/Fast-Gradient-Vector-Flow/actions/workflows/octave.yml/badge.svg)](https://github.com/wq2012/Fast-Gradient-Vector-Flow/actions/workflows/octave.yml)

This package implements the **Gradient Vector Flow (GVF)** algorithm in C++/MEX, offering significantly faster performance compared to standard MATLAB implementations.

## Table of Contents
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Copyright and Citation](#copyright-and-citation)

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

## Copyright and Citation


```
Copyright (C) 2012 Quan Wang <wangq10@rpi.edu>,
Signal Analysis and Machine Perception Laboratory,
Department of Electrical, Computer, and Systems Engineering,
Rensselaer Polytechnic Institute, Troy, NY 12180, USA
```

This software was developed as part of the following research. If you use this software in your research, please cite:

**Plain Text:**

> Quan Wang, Kim L. Boyer.
The active geometric shape model: A new robust deformable shape model and its applications.
Computer vision and image understanding 116, no. 12 (2012): 1178-1194.

> Quan Wang.
Exploiting Geometric and Spatial Constraints for Vision and Lighting Applications.
Ph.D. dissertation, Rensselaer Polytechnic Institute, 2014.

**BibTeX:**

```
@article{wang2012active,
  title={The active geometric shape model: A new robust deformable shape model and its applications},
  author={Wang, Quan and Boyer, Kim L},
  journal={Computer vision and image understanding},
  volume={116},
  number={12},
  pages={1178--1194},
  year={2012},
  publisher={Elsevier}
}

@phdthesis{wang2014exploiting,
  title={Exploiting Geometric and Spatial Constraints for Vision and Lighting Applications},
  author={Quan Wang},
  year={2014},
  school={Rensselaer Polytechnic Institute},
}
```
