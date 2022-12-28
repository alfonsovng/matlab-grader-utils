# Matlab Grader Utils

Set of code utilities for [Matlab Grader](https://grader.mathworks.com/). I started developing this utilities for a maths course at the [Polytechnic School of Engineering of Vilanova i la Geltrú](https://www.epsevg.upc.edu/en).

This project has the following utilities:

* [Grader Helper](./code/grader-helper): Class to simplify the assestments of a Matlab Grader problem.
* [Random Parameters](./code/random-parameters/): Class to generate random problems and also to get values from the learner solution.
* [Latex Plot](./code/latex-plot/): Function to show some lines of latex as an image.

Take a look to the examples:

* [Script problem using Grader Helper](./examples/1-script-problem-grader-helper/): A very simple example of a problem in Matlab Grader using `GraderHelper.m` to simplify the code of the assessments.

* [Script problem with personalized value for student](./examples/2-script-problem-personalized-value/): Small example of how to generate diferent problems, one for each student.

* [Script problem with personalized values shown as an image](./examples/3-script-problem-personalized-values-image/): Example of a problem with personalized values that the student can see running once the script.

* [Script problem with personalized statement given as PDF](./examples/4-script-problem-pdf-statement/): Example of a problem with personalized values that the student get printed from a generated PDF.
