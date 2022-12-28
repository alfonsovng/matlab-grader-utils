current_path = pwd;
addpath(genpath(current_path + "/.."));

problem1.email = 'foo@gmail.com';
problem1.F_LATEX = 'f(x) = x^2-4\,x+31';
problem1.A = 0;
problem1.B = 1;

problem2.email = 'bar@gmail.com';
problem2.F_LATEX = 'f(x) = \frac{{\sin\left(x\right)}^2}{4}';
problem2.A = '-\pi/2';
problem2.B = '\pi/2';

pdf_path = generate_pdf('test.xml', [problem1, problem2]);
disp(pdf_path);