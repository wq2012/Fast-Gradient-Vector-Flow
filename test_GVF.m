function test_GVF()
%TEST_GVF Unit tests for GVF and gaussianBlur functions.

    % Compile MEX if needed
    if exist('GVF', 'file') ~= 3
        fprintf('Compiling GVF.cpp...\n');
        try
            mex GVF.cpp;
            fprintf('Compilation successful.\n');
        catch ME
            error('Compilation failed: %s', ME.message);
        end
    end

    addpath(pwd);

    % Load Octave image package if needed
    if exist('OCTAVE_VERSION', 'builtin')
        pkg load image;
    end

    % Test 1: gaussianBlur basic execution
    fprintf('Test 1: gaussianBlur basic execution... ');
    I = ones(50, 50) * 100;
    s = 1;
    I_blurred = gaussianBlur(I, s);
    assert(all(size(I) == size(I_blurred)), 'Gaussian blur output size mismatch');
    assert(isa(I_blurred, 'double'), 'Gaussian blur output type mismatch');
    % Blur of constant image should be approx constant (ignoring boundary effects for now or center)
    % With 'replicate', it should be exactly flat for constant input.
    assert(abs(mean(I_blurred(:)) - 100) < 1e-5, 'Gaussian blur of constant image incorrect');
    fprintf('PASSED\n');

    % Test 2: GVF constant input
    fprintf('Test 2: GVF constant input... ');
    % GVF throws error if input is constant (fWrongRange) because max==min
    I_const = ones(20, 20);
    try
        [u, v] = GVF(I_const, 0.2, 0.2, 10);
        error('GVF should have thrown error for constant input');
    catch ME
        if ~strcmp(ME.identifier, 'MATLAB:GVF:fWrongRange')
            fprintf('Expected: MATLAB:GVF:fWrongRange, Got: %s\n', ME.identifier);
        end
        assert(strcmp(ME.identifier, 'MATLAB:GVF:fWrongRange'), 'Unexpected error identifier');
    end
    fprintf('PASSED\n');

    % Test 3: GVF basic execution on valid input
    fprintf('Test 3: GVF basic execution... ');
    [X, Y] = meshgrid(-10:10, -10:10);
    I_grad = X.^2 + Y.^2; % Bowl shape
    I_grad = (I_grad - min(I_grad(:))) / (max(I_grad(:)) - min(I_grad(:))); % Normalize
    
    alpha = 0.1;
    mu = 0.1;
    iter = 5;
    
    [u, v] = GVF(I_grad, alpha, mu, iter);
    
    assert(all(size(u) == size(I_grad)), 'GVF u output size mismatch');
    assert(all(size(v) == size(I_grad)), 'GVF v output size mismatch');
    assert(~any(isnan(u(:))), 'GVF u contains NaNs');
    assert(~any(isnan(v(:))), 'GVF v contains NaNs');
    fprintf('PASSED\n');

    % Test 4: GVF input size check
    fprintf('Test 4: GVF small input check... ');
    I_small = rand(5, 5);
    try
        [u, v] = GVF(I_small, 0.2, 0.2, 10);
        error('GVF should have thrown error for small input');
    catch ME
        assert(strcmp(ME.identifier, 'MATLAB:GVF:fWrongSize'), 'Unexpected error identifier for small input');
    end
    fprintf('PASSED\n');
    
    % Test 5: Parameter validation
    fprintf('Test 5: Parameter validation... ');
    I_valid = rand(20, 20);
    % Make sure it's not constant
    I_valid(1,1) = 0; I_valid(1,2) = 1;

    try
        [u, v] = GVF(I_valid, -0.1, 0.2, 10);
        error('Should fail for negative alpha');
    catch ME
        assert(strcmp(ME.identifier, 'MATLAB:GVF:alphaWrongRange'), 'Unexpected error for negative alpha');
    end

    try
        [u, v] = GVF(I_valid, 0.1, -0.2, 10);
        error('Should fail for negative mu');
    catch ME
        assert(strcmp(ME.identifier, 'MATLAB:GVF:muWrongRange'), 'Unexpected error for negative mu');
    end
    
    try
        [u, v] = GVF(I_valid, 0.1, 0.2, 0);
        error('Should fail for non-positive iter');
    catch ME
        assert(strcmp(ME.identifier, 'MATLAB:GVF:iterWrongRange'), 'Unexpected error for invalid iter');
    end
    fprintf('PASSED\n');

    fprintf('All tests passed!\n');
end
