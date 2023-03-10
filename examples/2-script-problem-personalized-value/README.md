# Script problem with personalized value for student

## Description

Small example of how to generate diferent problems, one for each student.

The scenario is that we have a group of 100 students, each one with and id between 1 and 100 (beautiful, isn't it?). So we prepare a problem using the function defined in [this geogebra plot](https://www.geogebra.org/classic/snaqghfa).

## Instructions

Create a new script problem in your Matlab Grader.

Add to the problem the following files:

* [GraderHelper.m](../../code/grader-helper/GraderHelper.m)
* [RandomParameters.m](../../code/random-parameters/RandomParameters.m)

Take a look to the screenshots:

* [Screenshot of the reference solution](./screenshots/screenshot_reference.png)
* [Screenshot of the reference solution validated](./screenshots/screenshot_reference_validated.png)
* [Screenshot of the learner preview](./screenshots/screenshot_learner.png)
* [Screenshot of the learner submitted](./screenshots/screenshot_learner_submitted.png)

The code of the screenshots is here:

* [Reference solution](./reference.m)
* [Learner template](./learner.m)
* [Assessments](./assessments.m)
