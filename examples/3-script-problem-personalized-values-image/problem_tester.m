current_path = pwd;
addpath(genpath(current_path + "/../../code/random-parameters"));
addpath(genpath(current_path + "/../../code/latex-plot"));

% gets and shows the personalized values for this student
email1 = "some-student@random-school.edu";
problem1 = Problem.show_problem(email1, 'SuperSecretPassword');
disp(problem1);

% gets and shows the personalized values for this student
email2 = 'another-student@random-school.edu';
problem2 = Problem.show_problem(email2, 'SuperSecretPassword');
disp(problem2);