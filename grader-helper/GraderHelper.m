classdef GraderHelper
    properties (Constant, Access = private)
        SHOW_LOG = false;     
        FUNCTION_NUMBER_POINTS_TO_CHECK = 13;
        FUNCTION_DEFAULT_INTERVAL = [-10 10];

        SOLUTION_FILE_VARIABLE_NAME = 'grader_helper_solution';
    end

    methods(Static)
        function lines = save_plot(figure, close_it)
            if nargin < 2
                close_it = false;
            end
            try
                lines = copy(findobj(figure.CurrentAxes,'Type','FunctionLine'));
                if close_it
                    close(figure);
                end
            catch exception
                fprintf("\n>>>>>>>>>> ERROR >>>>>>>>>>\n");
                fprintf(getReport(exception,'basic','hyperlinks','off'));
                GraderHelper.log(getReport(exception));
                fprintf("\n<<<<<<<<<< ERROR <<<<<<<<<<\n");
                lines = NaN;
            end        
        end

        function file_name = store_solution(varargin)
            % unique file with .mat extension
            file_name = [tempname('.') '.mat'];

            GraderHelper.log('Store solution at %s', file_name);

            for n = 1:nargin
                variable_name = varargin{n};
                variable_value = evalin('caller', varargin{n});
                GraderHelper.assignhere(variable_name, variable_value);
            end

            save(file_name, varargin{:});
        end

        function assert_equal(variable_name, varargin)
            % get the name of the files with the learner and reference solution
            try
                learner_solution = evalin('caller', GraderHelper.SOLUTION_FILE_VARIABLE_NAME);
                reference_solution = evalin('caller', sprintf('referenceVariables.%s', GraderHelper.SOLUTION_FILE_VARIABLE_NAME));
            catch exception
                GraderHelper.log(getReport(exception));

                error('Files with variable %s not found. Script with syntax errors that could not be executed', variable_name);
            end

            try
                learner_value = load(learner_solution, variable_name).(variable_name);
                reference_value = load(reference_solution, variable_name).(variable_name);
            catch exception
                GraderHelper.log(getReport(exception));       

                error('Variable %s not found. Script with syntax errors that could not be executed', variable_name);
            end

            class_learner_value = class(learner_value);
            class_reference_value = class(reference_value);

            % check that they are the same class
            GraderHelper.check(variable_name, class_learner_value, class_reference_value, 'Feedback','Wrong type or not defined yet');

            GraderHelper.log('Class of %s: %s', variable_name, class_reference_value);

            switch class_reference_value
                case 'function_handle'
                    GraderHelper.check_functions(variable_name, learner_value, reference_value, varargin{:});
                case 'matlab.graphics.function.FunctionLine'
                    GraderHelper.check_graphics(variable_name, learner_value, reference_value, varargin{:});
                otherwise % numbers or strings... generic check
                    GraderHelper.check(variable_name, learner_value, reference_value, varargin{:});
            end
        end
    end

    methods(Static, Access = private)
        function log(varargin)
            if GraderHelper.SHOW_LOG
                fprintf('LOG - ')
                fprintf(varargin{:});
                fprintf('\n');
            end
        end

        function str = to_debug_str(anything)
            str = matlab.unittest.diagnostics.ConstraintDiagnostic.getDisplayableString(anything);
        end

        function check(variable_name, learner_value, reference_value, varargin)
            if GraderHelper.SHOW_LOG
                GraderHelper.log('Check %s:\n%s\n%s\n', variable_name, GraderHelper.to_debug_str(learner_value), GraderHelper.to_debug_str(reference_value)); 
            end
            GraderHelper.assignhere(variable_name, learner_value);
            assessVariableEqual(variable_name, reference_value, varargin{:});
        end

        % https://stackoverflow.com/a/51245813
        function assignhere(varname,varvalue)
            assignin('caller',varname,varvalue);
        end

        function check_functions(variable_name, learner_function, reference_function, varargin)
            p = inputParser;
            addOptional(p,'Interval', GraderHelper.FUNCTION_DEFAULT_INTERVAL);
            parse(p, varargin{:});

            a = p.Results.Interval(1);
            b = p.Results.Interval(2);
            x = linspace(a,b,GraderHelper.FUNCTION_NUMBER_POINTS_TO_CHECK);

            GraderHelper.check(variable_name, learner_function(x), reference_function(x),'Feedback','The function is not rigth');
        end

        function check_graphics(variable_name, learner_lines, reference_lines, varargin)
            number_of_lines = length(learner_lines);

            GraderHelper.check(variable_name, number_of_lines,length(reference_lines),'Feedback','The chart does not contain the requested number of plots');

            for n = 1:number_of_lines
                % lines from the plot are LIFO
                error_msg_prefix = sprintf('[plot %s] ', string(number_of_lines + 1 - n)); 
                
                GraderHelper.check(variable_name, learner_lines(n).Color, reference_lines(n).Color,'Feedback', [error_msg_prefix 'wrong color']);
                GraderHelper.check(variable_name, learner_lines(n).LineStyle, reference_lines(n).LineStyle,'Feedback',[error_msg_prefix 'wrong line style']);
                GraderHelper.check(variable_name, learner_lines(n).LineWidth, reference_lines(n).LineWidth,'Feedback',[error_msg_prefix 'wrong line width']);
                GraderHelper.check(variable_name, learner_lines(n).XRange, reference_lines(n).XRange,'Feedback',[error_msg_prefix 'wrong range']);
            end  
        end
    end
end
