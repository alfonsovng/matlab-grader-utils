current_path = pwd;
addpath(genpath(current_path + "/.."));
addpath(genpath(current_path + "/../../../code/pdf-statement"));
addpath(genpath(current_path + "/../../../code/random-parameters"));
addpath(genpath(current_path + "/../../../code/latex-plot"));

number_of_students = 5;

problems = cell(1,number_of_students);
for id=1:number_of_students
    problem = Problem.show_problem(id, 'ReturnProblem', true, 'HidePlot', true);
    problems{id} = problem;
end

pdf_path = generate_pdf('statement.xml', cell2mat(problems));
disp(pdf_path);