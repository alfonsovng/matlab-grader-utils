classdef GraderHelper
    properties (Constant, Access = private)
        DEBUG_MODE = false;

        REPORT_MODE_FILE_FLAG = 'REPORT.MODE';
        DEFAULT_REPORT_MODE = false;     
        
        FUNCTION_NUMBER_POINTS_TO_CHECK = 13;
        FUNCTION_DEFAULT_INTERVAL = [-10 10];
    end
    methods(Static)
        function lines = save_plot(figure, close_it)
            if nargin < 2
                close_it = false;
            end
            try
                lines = copy(findobj(figure.CurrentAxes,'Type','Line'));
                if isequal(class(lines),'matlab.graphics.GraphicsPlaceholder')
                    % maybe if it is a fplot instead of a plot
                    lines = copy(findobj(figure.CurrentAxes,'Type','FunctionLine'));
                end
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

        function assert_equal(variable_name, varargin)
            % defines the report mode
            report_mode = GraderHelper.DEFAULT_REPORT_MODE || isfile(GraderHelper.REPORT_MODE_FILE_FLAG);

            % get the name of the files with the learner and reference solution
            try
                learner_value = evalin('caller', variable_name);
                reference_value = evalin('caller', sprintf('referenceVariables.%s', variable_name));
            catch exception
                GraderHelper.log(getReport(exception));

                error('Variable %s not found. Script with syntax errors that could not be executed', variable_name);
            end

            gh = GraderHelper(report_mode, variable_name);
            gh.check(learner_value, reference_value, varargin{:});
        end
    end
    properties
        report_mode;
        variable_name;
    end
    methods(Access = private)
        function obj = GraderHelper(report_mode, variable_name)
            obj.report_mode = report_mode;
            obj.variable_name = variable_name;
        end

        function check(obj, learner_value, reference_value, varargin)
            class_learner_value = class(learner_value);
            class_reference_value = class(reference_value);

            % check that they are the same class
            obj.check_value(class_learner_value, class_reference_value, 'Feedback','Wrong type or not defined yet');

            GraderHelper.log('Class of %s: %s', obj.variable_name, class_reference_value);

            switch class_reference_value
                case 'function_handle'
                    obj.check_functions(learner_value, reference_value, varargin{:});
                case 'matlab.graphics.chart.primitive.Line'
                    obj.check_lines(learner_value, reference_value, varargin{:});
                case 'matlab.graphics.function.FunctionLine'
                    obj.check_function_lines(learner_value, reference_value, varargin{:});
                otherwise % numbers or strings... generic check
                    obj.check_value(learner_value, reference_value, varargin{:});
            end
        end

        function check_value(obj, learner_value, reference_value, varargin)
            if obj.report_mode || GraderHelper.DEBUG_MODE
                extra_feedback = sprintf('REPORT MODE => Check %s with varargin %s\n\tL:%s\n\tR:%s', obj.variable_name, strjoin(string(varargin),','), GraderHelper.to_debug_str(learner_value), GraderHelper.to_debug_str(reference_value));
                GraderHelper.log(extra_feedback);

                if obj.report_mode
                    varargin = [varargin, 'Feedback', extra_feedback];
                end
            end
            GraderHelper.assignhere(obj.variable_name, learner_value);
            assessVariableEqual(obj.variable_name, reference_value, varargin{:});
        end

        function check_functions(obj, learner_function, reference_function, varargin)
            p = inputParser;
            addOptional(p,'Interval', GraderHelper.FUNCTION_DEFAULT_INTERVAL);
            addOptional(p,'Feedback', 'The function is not rigth');
            parse(p, varargin{:});

            a = p.Results.Interval(1);
            b = p.Results.Interval(2);
            x = linspace(a,b,GraderHelper.FUNCTION_NUMBER_POINTS_TO_CHECK);

            obj.check_value(learner_function(x), reference_function(x),'Feedback',p.Results.Feedback);
        end

        function check_lines(obj, learner_lines, reference_lines, varargin)
            number_of_lines = length(learner_lines);

            obj.check_value(number_of_lines,length(reference_lines),'Feedback','The chart does not contain the requested number of lines');

            GraderHelper.log('Lines %d. Check color, line style, line width and range for each one', number_of_lines);

            for n = 1:number_of_lines
                % lines from the plot are LIFO
                error_msg_prefix = sprintf('[line %s] ', string(number_of_lines + 1 - n)); 
                
                obj.check_value(learner_lines(n).Color, reference_lines(n).Color,'Feedback',[error_msg_prefix 'wrong color']);
                obj.check_value(learner_lines(n).LineStyle, reference_lines(n).LineStyle,'Feedback',[error_msg_prefix 'wrong line style']);
                obj.check_value(learner_lines(n).LineWidth, reference_lines(n).LineWidth,'Feedback',[error_msg_prefix 'wrong line width']);
                obj.check_value(learner_lines(n).XData, reference_lines(n).XData,'Feedback',[error_msg_prefix 'wrong x data']);
                obj.check_value(learner_lines(n).YData, reference_lines(n).YData,'Feedback',[error_msg_prefix 'wrong y data']);
            end  
        end

        function check_function_lines(obj, learner_lines, reference_lines, varargin)
            number_of_lines = length(learner_lines);

            obj.check_value(number_of_lines,length(reference_lines),'Feedback','The chart does not contain the requested number of lines');

            GraderHelper.log('Lines %d. Check color, line style, line width and range for each one', number_of_lines);

            for n = 1:number_of_lines
                % lines from the plot are LIFO
                error_msg_prefix = sprintf('[line %s] ', string(number_of_lines + 1 - n)); 
                
                obj.check_value(learner_lines(n).Color, reference_lines(n).Color,'Feedback',[error_msg_prefix 'wrong color']);
                obj.check_value(learner_lines(n).LineStyle, reference_lines(n).LineStyle,'Feedback',[error_msg_prefix 'wrong line style']);
                obj.check_value(learner_lines(n).LineWidth, reference_lines(n).LineWidth,'Feedback',[error_msg_prefix 'wrong line width']);
                obj.check_value(learner_lines(n).XRange, reference_lines(n).XRange,'Feedback',[error_msg_prefix 'wrong range']);

                % check also the function
                obj.check_functions(learner_lines(n).Function, reference_lines(n).Function,'Interval',learner_lines(n).XRange,'Feedback',[error_msg_prefix 'wrong function'])
            end  
        end
    end
    methods(Static, Access = private)
        function log(varargin)
            if GraderHelper.DEBUG_MODE
                fprintf('LOG - ')
                fprintf(varargin{:});
                fprintf('\n');
            end
        end

        function str = to_debug_str(anything)
            str = matlab.unittest.diagnostics.ConstraintDiagnostic.getDisplayableString(anything);
        end

        % https://stackoverflow.com/a/51245813
        function assignhere(varname, varvalue)
            assignin('caller',varname,varvalue);
        end
    end
end
