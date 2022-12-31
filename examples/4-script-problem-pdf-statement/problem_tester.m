current_path = pwd;
addpath(genpath(current_path + "/../../code/random-parameters"));
addpath(genpath(current_path + "/../../code/latex-plot"));

for id=1:5
    problem = Problem.show_problem(id, 'ReturnProblem', true);
    disp(problem);
end
