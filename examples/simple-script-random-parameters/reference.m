% define A, number between 1 and 100
A = 90; % value that will be used to Validate Reference Solution

% gets value from the learner solution
A = RandomParameters.get_number_value_from_learner('A');
if A < 1 || A > 100
    error('Value A is not a number between 1 and 100');
else
    A % shows A value that we are using
end

% function
f = @(x) x.^2 + 2*x - A; 

% plot
figure1 = figure;
fplot(f, [-20 20], '-b', 'LineWidth', 2);
plot_f = GraderHelper.save_plot(figure1); 

% roots, where a < b
a = fzero(f,-20)
b = fzero(f,20)