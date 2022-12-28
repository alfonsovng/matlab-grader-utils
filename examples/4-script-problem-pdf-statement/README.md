# Script problem with personalized statement given as PDF

## Description

Example of a problem with personalized values that the student get printed from a generated PDF.

The scenario is that each students will get a (printed?) PDF with a personalized statement. The problem is using the function defined in [this geogebra plot](https://www.geogebra.org/classic/gukr4ecy).

Take a look to the `Problem.m` file, that contains all the personalized funcion generation for this particular problem The idea is to create a different `Problem.m` for each problem you want to publish. The script `problem-tester.m` is to run and test the `Problem.m` class in your local Matlab runtime.
