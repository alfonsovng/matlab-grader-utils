current_path = pwd;
addpath(genpath(current_path + "/.."));
addpath(genpath(current_path + "/../MATLABGraderTestPackage"));

%
% Reference variables to test
%

% function
referenceVariables.f = @(x) x.^2 + 5*x + 2; 
% plot
figure1 = figure;
fplot(referenceVariables.f, [0 10], '-r', 'LineWidth', 3);
referenceVariables.plot_f = GraderHelper.save_plot(figure1, true); 
% text
referenceVariables.name = 'Alfonso';
% numbers
referenceVariables.a = 10;
referenceVariables.b = 5e-10;
referenceVariables.c = -0.00000012;
referenceVariables.d = exp(-sin(pi/4));
% intervals
referenceVariables.i = [-10 200];

%
% TESTS
%

% ok
f = @(x) x.^2 + 5*x + 2; 
check_ok('f');
check_ok('f', 'Interval', [0 5]);

figure1 = figure;
fplot(f, [0 10], '-r', 'LineWidth', 3);
plot_f = GraderHelper.save_plot(figure1, true); 
check_ok('plot_f');

name = 'Alfonso';
check_ok('name');

a = 10;
check_ok('a');

b = 5e-10;
check_ok('b');

c = -0.00000012;
check_ok('c');

d = exp(-sin(pi/4));
check_ok('d');

i = [-10 200];
check_ok('i');

% function ok
% f = @(x) x.^2 + 5*x + 2; 
f = @(x) x.*x + 6*x - x + 1 + 1; 
check_ok('f');

% function error
% f = @(x) x.^2 + 5*x + 2; 
f = @(x) x.^2 + 5*x + 3; 
check_error('wrong definition', 'f');

% % plot error by points
% % f = @(x) x.^2 + 5*x + 2; 
% f = @(x) x.^2 + 5*x + 3; 
% figure1 = figure;
% fplot(f, [0 10], '-r', 'LineWidth', 3);
% plot_f = GraderHelper.save_plot(figure1, true); 
% check_error('points', 'plot_f');

% plot error by color
f = @(x) x.^2 + 5*x + 2; 
figure1 = figure;
fplot(f, [0 10], '-b', 'LineWidth', 3);
plot_f = GraderHelper.save_plot(figure1, true); 
check_error('color', 'plot_f');

% plot error by line
f = @(x) x.^2 + 5*x + 2; 
figure1 = figure;
fplot(f, [0 10], '.r', 'LineWidth', 3);
plot_f = GraderHelper.save_plot(figure1, true); 
check_error('line style', 'plot_f');

% plot error by range
f = @(x) x.^2 + 5*x + 2; 
figure1 = figure;
fplot(f, [0 11], '-r', 'LineWidth', 3);
plot_f = GraderHelper.save_plot(figure1, true); 
check_error('range', 'plot_f');

% plot error by line width
f = @(x) x.^2 + 5*x + 2; 
figure1 = figure;
fplot(f, [0 10], '-r', 'LineWidth', 2);
check_error('line width', 'plot_f');

% text error
% name = 'Alfonso';
name = 'Alfons0';
check_error('wrong value', 'name');

% number error
% a = 10
a = 11;
check_error('wrong value', 'a');

% number error with absolute tolerance
% a = 10
a = 10.00001;
check_ok('a');
check_error('wrong value', 'a', 'AbsoluteTolerance', 1e-6);

% number error with relative tolerance
% c = -0.00000012;
c = -0.00000013;
check_ok('c');
check_error('wrong value', 'c', 'RelativeTolerance', 1e-2);

% interval error
i = [-10 201];
check_error('wrong value', 'i');

function check_ok(variable_name, varargin)
    % the assert_equal will try to find these vars
    assignhere(variable_name, evalin('caller', variable_name));
    referenceVariables.(variable_name) = evalin('caller', sprintf('referenceVariables.%s', variable_name));

    try
        GraderHelper.assert_equal(variable_name, varargin{:});
        fprintf('\n\tassert_equal(%s) is ok\n', variable_name);
    catch exception                    
        error_msg = getReport(exception,'basic','hyperlinks','off');
        error('Unexpected error checking %s: %s\n', variable_name, error_msg);
    end
end

function check_error(why, variable_name, varargin)
    % the assert_equal will try to find these vars
    assignhere(variable_name, evalin('caller', variable_name));
    referenceVariables.(variable_name) = evalin('caller', sprintf('referenceVariables.%s', variable_name));

    try
        GraderHelper.assert_equal(variable_name, varargin{:});
    catch exception
        error_msg = getReport(exception,'basic','hyperlinks','off');
        fprintf('\n\tassert_equal(%s) is wrong because of %s, but it is ok: %s\n', variable_name, why, error_msg);
        return;
    end
    fprintf('\n\tassert_equal(%s) did not fail because of %s and it is wrong!\n', variable_name, why);
    error('Expected error checking %s because of %s, but it dit not happen\n', variable_name, why);
end

% https://stackoverflow.com/a/51245813
function assignhere(varname,varvalue)
    assignin('caller',varname,varvalue);
end