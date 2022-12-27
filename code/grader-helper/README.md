# Matlab Grader Helper

Helper code for matlab grader.

## Reference Solution:

```matlab
% function
f = @(x) x.^2 + 2*x - 8; 

% plot
figure1 = figure;
fplot(f, [-5 5], '-r', 'LineWidth', 3);
plot_f = GraderHelper.save_plot(figure1); 

% roots, where a < b
a = -4;
b = 2;
```

## Learner Template:

```matlab
% function
f = NaN;

% plot
figure1 = figure;

plot_f = GraderHelper.save_plot(figure1); 

% roots, where a < b
a = NaN;
b = NaN;
```

## Assessments:

Create the following 4 assessments choosing 'MATLAB Code':

```matlab
GraderHelper.assert_equal('f');

GraderHelper.assert_equal('plot_f');

GraderHelper.assert_equal('a');

GraderHelper.assert_equal('b');
```
