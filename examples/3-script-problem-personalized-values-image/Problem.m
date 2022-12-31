classdef Problem
    methods(Static)
        % shows the problem as an image using LatexPlot.m
        function problem_to_return = show_problem(email, varargin)
            p = inputParser;
            addOptional(p, 'ReturnProblem', false);
            parse(p, varargin{:});

            problem = Problem.get_problem(email);

            syms x;
            latex_f = ['$$ f(x) = ' latex(problem.f(x)) '$$'];

            lines = {
                ['email : ' email],...
                latex_f,...
                sprintf('$$COLOR = %s$$', problem.color_name),...
                sprintf('$$LINE\\_WIDTH = %d$$',problem.line_width)
            };

            LatexPlot.show(lines);

            % only gets this struct in the reference solution
            if p.Results.ReturnProblem
                problem_to_return = problem;
            else
                problem_to_return = NaN;
            end
        end
    end
    methods(Static, Access = private)
        % generates a problem using RandomParameters
        function problem = get_problem(email)
            % check that the email is valid
            assert(ischar(email) || isstring(email), 'Invalid email');
            assert(endsWith(email, '@random-school.edu'), 'Invalid email');

            % each problem should have a different salt, to avoid repetition of values
            salt = 'Any random text, like this, is valid as a salt. Change it to get different values.';
            parameters = RandomParameters(email, salt);

            % https://www.geogebra.org/classic/kwkcgc2x
            A = parameters.get_double_between(-10, -0.5, 2); % 2 decimals
            B = parameters.get_double_between(-5, 5, 2); % 2 decimals
            C = parameters.get_double_between(-8, 8, 2); % 2 decimals

            % color of the plot
            color = parameters.get_from_cell_array({{'blue', '-b'}, {'green', '-g'}, {'black', '-k'}, {'yellow', '-y'}, {'red', '-r'}});

            % width of the plot
            line_width = parameters.get_int_between(1, 4);

            % struct with all the personalized values of the problem
            problem.f = @(x) A*x.^2 + B*x + C;
            problem.color_name = color{1};
            problem.color_code = color{2};
            problem.line_width = line_width;
        end
    end
end