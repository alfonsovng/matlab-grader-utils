current_path = pwd;
addpath(genpath(current_path + "/.."));
addpath(genpath(current_path + "/../MATLABGraderTestPackage"));

reference_solution = reference();
learner_solution = reference();

% ok
check_ok('f');
check_ok('f', 'Interval', [0 5]);
check_ok('plot_f');
check_ok('name');
check_ok('a');
check_ok('b');
check_ok('c');
check_ok('d');
check_ok('i');

% function ok
% f = @(x) x.^2 + 5*x + 2; 
f = @(x) x.*x + 6*x - x + 1 + 1; 
learner_solution = GraderHelper.store_solution('f');
check_ok('f');


% function error
% f = @(x) x.^2 + 5*x + 2; 
f = @(x) x.^2 + 5*x + 3; 
learner_solution = GraderHelper.store_solution('f');
check_error('wrong definition', 'f');

% % plot error by points
% % f = @(x) x.^2 + 5*x + 2; 
% f = @(x) x.^2 + 5*x + 3; 
% figure1 = figure;
% fplot(f, [0 10], '-r', 'LineWidth', 3);
% plot_f = GraderHelper.save_plot(figure1, true); 
% learner_solution = GraderHelper.store_solution('plot_f');
% check_error('points', 'plot_f');

% plot error by color
f = @(x) x.^2 + 5*x + 2; 
figure1 = figure;
fplot(f, [0 10], '-b', 'LineWidth', 3);
plot_f = GraderHelper.save_plot(figure1, true); 
learner_solution = GraderHelper.store_solution('plot_f');
check_error('color', 'plot_f');

% plot error by line
f = @(x) x.^2 + 5*x + 2; 
figure1 = figure;
fplot(f, [0 10], '.r', 'LineWidth', 3);
plot_f = GraderHelper.save_plot(figure1, true); 
learner_solution = GraderHelper.store_solution('plot_f');
check_error('line style', 'plot_f');

% plot error by range
f = @(x) x.^2 + 5*x + 2; 
figure1 = figure;
fplot(f, [0 11], '-r', 'LineWidth', 3);
plot_f = GraderHelper.save_plot(figure1, true); 
learner_solution = GraderHelper.store_solution('plot_f');
check_error('range', 'plot_f');

% plot error by line width
f = @(x) x.^2 + 5*x + 2; 
figure1 = figure;
fplot(f, [0 10], '-r', 'LineWidth', 2);
learner_solution = GraderHelper.store_solution('plot_f');
check_error('line width', 'plot_f');

% text error
% name = 'Alfonso';
name = 'Alfons0';
learner_solution = GraderHelper.store_solution('name');
check_error('wrong value', 'name');

% number error
% a = 10
a = 11;
learner_solution = GraderHelper.store_solution('a');
check_error('wrong value', 'a');

% number error with absolute tolerance
% a = 10
a = 10.00001;
learner_solution = GraderHelper.store_solution('a');
check_ok('a');
check_error('wrong value', 'a', 'AbsoluteTolerance', 1e-6);

% number error with relative tolerance
% c = -0.00000012;
c = -0.00000013;
learner_solution = GraderHelper.store_solution('c');
check_ok('c');
check_error('wrong value', 'c', 'RelativeTolerance', 1e-2);


function check_ok(variable_name, varargin)

    % the assert_equal will try to find these vars
    grader_helper_solution = evalin('caller', 'learner_solution');
    referenceVariables.grader_helper_solution = evalin('caller', 'reference_solution');

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
    grader_helper_solution = evalin('caller', 'learner_solution');
    referenceVariables.grader_helper_solution = evalin('caller', 'reference_solution');

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
