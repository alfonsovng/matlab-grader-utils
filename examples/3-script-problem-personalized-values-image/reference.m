% email used in the 'Validate Reference Solution' 
email = 'some-student@random-school.edu';

% email from the learner
email = RandomParameters.get_str_value_from_learner('email');

% shows and gets the personalized values for this email
problem = Problem.show_problem(email, 'Password', 'SuperSecretPassword');

% function
f = problem.f;

% plot
figure1 = figure;
fplot(f, [-20 20], problem.color_code, 'LineWidth', problem.line_width);
plot_f = GraderHelper.save_plot(figure1);