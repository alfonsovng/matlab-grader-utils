% function
f = NaN;

% plot
figure1 = figure;

plot_f = GraderHelper.save_plot(figure1); 

% roots, where a < b
a = NaN;
b = NaN;

% store the solution
grader_helper_solution = GraderHelper.store_solution('f', 'plot_f', 'a', 'b');