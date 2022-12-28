# Script problem with personalized values shown as an image

## Description

Example of a problem with personalized values that the student can see running once the script.

The scenario is that the students will have to put ther student email (XXX@@random-school.edu) and run once the script to view their personalized values. The problem is using the function defined in [this geogebra plot](https://www.geogebra.org/classic/kwkcgc2x).

Take a look to the `Problem.m` file, that contains all the personalized funcion generation for this particular problem The idea is to create a different `Problem.m` for each problem you want to publish. The script `problem_tester.m` is to run and test the `Problem.m` class in your local Matlab runtime.

## Instructions

Create a new script problem in your Matlab Grader.

Add to the problem the following files:

* [GraderHelper.m](../../code/grader-helper/GraderHelper.m)
* [RandomParameters.m](../../code/random-parameters/RandomParameters.m)
* [LatexPlot.m](../../code/latex-plot/LatexPlot.m)
* [Problem.m](./Problem.m)

Take a look to the screenshots:

* [Screenshot of the reference solution](./screenshots/screenshot_reference.png)
* [Screenshot of the reference solution validated](./screenshots/screenshot_reference_validated.png)
* [Screenshot of the learner preview](./screenshots/screenshot_learner.png)
* [Screenshot of the learner first sumit to view the problem](./screenshots/screenshot_learner_with_email.png)
* [Screenshot of the learner submitted](./screenshots/screenshot_learner_submitted.png)

The code of the screenshots is here:

* [Reference solution](./reference.m)
* [Learner template](./learner.m)
* [Assessments](./assessments.m)
