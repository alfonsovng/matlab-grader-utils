% function
f = @(x) x.^2 + 2*x - 8; 

% plot
figure1 = figure;
fplot(f, [-5 5], '-r', 'LineWidth', 3);
plot_f = GraderHelper.save_plot(figure1); 

% roots, where a < b
a = -4;
b = 2;

% store the solution
grader_helper_solution = GraderHelper.store_solution('f', 'plot_f', 'a', 'b');