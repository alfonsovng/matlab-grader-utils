% id used in the 'Validate Reference Solution' 
id = 1;

% id from the learner
id = RandomParameters.get_number_value_from_learner('id');

% shows and gets the personalized values for this email
problem = Problem.show_problem(id, 'ReturnProblem', true);

% function
f = problem.f;

% plot
figure1 = figure;
fplot(f, [-1 16], problem.color_code, 'LineWidth', problem.line_width);
plot_f = GraderHelper.save_plot(figure1);

% integral
I = integral(f,0,problem.n,'AbsTol',5e-15);
