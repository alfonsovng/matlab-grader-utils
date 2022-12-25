function grader_helper_solution = reference()
    % function
    f = @(x) x.^2 + 5*x + 2; 

    % plot
    figure1 = figure;
    fplot(f, [0 10], '-r', 'LineWidth', 3);
    plot_f = GraderHelper.save_plot(figure1, true); 

    % text
    name = 'Alfonso';

    % numbers
    a = 10;
    b = 5e-10;
    c = -0.00000012;
    d = exp(-sin(pi/4));

    % intervals
    i = [-10 200];

    % store the solution
    grader_helper_solution = GraderHelper.store_solution('f', 'plot_f', 'name', 'a', 'b', 'c', 'd', 'i');
end