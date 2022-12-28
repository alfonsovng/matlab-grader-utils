classdef Problem
    properties (Constant, Access = private)
        % password to avoid students get the problem struct
        PASSWORD_TO_GET_STRUCT = 'SuperSecretPassword';
    end
    methods(Static)
        % shows the problem as an image using LatexPlot.m
        function problem_to_return = show_problem(id, varargin)
            p = inputParser;
            addOptional(p,'Password', '');
            addOptional(p,'HidePlot', false, @islogical);
            parse(p, varargin{:});

            problem = Problem.get_problem(id);

            if ~p.Results.HidePlot
                lines = {
                    sprintf('$$id = %d$$', id),...
                    sprintf('$$%s$$',problem.latex_f),...
                    sprintf('$$n = %d$$', problem.n),...
                    sprintf('$$COLOR = %s$$', problem.color_name),...
                    sprintf('$$LINE\\_WIDTH = %d$$',problem.line_width)
                };
    
                LatexPlot.show(lines);
            end

            % only gets this struct in the reference solution
            if isequal(p.Results.Password, Problem.PASSWORD_TO_GET_STRUCT)
                problem_to_return = problem;
            else
                problem_to_return = NaN;
            end
        end
    end
    methods(Static, Access = private)
        % generates a problem using RandomParameters
        function problem = get_problem(id)
            % check that the id is valid: integer between 1 and 5
            % https://es.mathworks.com/matlabcentral/answers/16390-integer-check#comment_36218
            assert(mod(id,1) == 0 && id>=1 && id<=5, 'Invalid id');

            % each problem should have a different salt, to avoid repetition of values
            salt = 'Any random text, like this, is valid as a salt. Change it to get different values. Or not ;)';
            parameters = RandomParameters(id, salt);

            % https://www.geogebra.org/classic/gukr4ecy
            A = parameters.get_double_between(1, 9, 2); % 2 decimals
            B = parameters.get_double_between(0.1, 1.8, 2); % 2 decimals
            n = parameters.get_int_between(1, 15);

            % color of the plot
            color = parameters.get_from_cell_array({{'blue', '-b'}, {'green', '-g'}, {'black', '-k'}, {'yellow', '-y'}, {'red', '-r'}});

            % width of the plot
            line_width = parameters.get_int_between(1, 4);

            % f & latex_f
            f = @(x) sin(A*x) + B*x;
            syms x;
            latex_f = ['f(x) = ' latex(f(x))];

            % struct with all the personalized values of the problem
            problem.id = id;
            problem.f = f;
            problem.latex_f = latex_f;
            problem.n = n;
            problem.color_name = color{1};
            problem.color_code = color{2};
            problem.line_width = line_width;
        end
    end
end