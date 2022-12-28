% define STUDENT_ID, a number between 1 and 100
STUDENT_ID = 90; % value that will be used to Validate Reference Solution

% gets STUDENT_ID value from the learner solution
STUDENT_ID = RandomParameters.get_number_value_from_learner('STUDENT_ID');
if STUDENT_ID < 1 || STUDENT_ID > 100
    error('Value STUDENT_ID is not a number between 1 and 100');
else
    STUDENT_ID % shows the STUDENT_ID value that we are using
end

% function
f = @(x) x.^2 + 2*x - STUDENT_ID; 

% plot
figure1 = figure;
fplot(f, [-20 20], '-b', 'LineWidth', 2);
plot_f = GraderHelper.save_plot(figure1); 

% roots, where a < b
a = fzero(f,-20)
b = fzero(f,20)
