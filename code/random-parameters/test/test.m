current_path = pwd;
addpath(genpath(current_path + "/.."));

id = 'name@mail.from.student';
salt = 49112;

p1 = RandomParameters(id, salt);
p2 = RandomParameters(id, salt);

% get_double_between
v1 = p1.get_double_between(0, 200, 3);
v2 = p2.get_double_between(0, 200, 3);
fprintf('%g == %g?\n', v1, v2);
assert(isequal(v1, v2), 'get_double_between is not equal');

% get_int_between
v1 = p1.get_int_between(-100, 100);
v2 = p2.get_int_between(-100, 100);
fprintf('%g == %g?\n', v1, v2);
assert(isequal(v1, v2), 'get_int_between is not equal');

% get_from_cell_array
values = {0 1 2 3 4 5 6 7 8 9};
v1 = p1.get_from_cell_array(values);
v2 = p2.get_from_cell_array(values);
fprintf('%g == %g?\n', v1, v2);
assert(isequal(v1, v2), 'get_from_cell_array is not equal');

% read a number from the learner solution
expected_value = 10;
learner_value = RandomParameters.get_number_value_from_learner('integer_number');
fprintf('%g == %g?\n', expected_value, learner_value);
assert(isequal(learner_value, expected_value), 'get_number_value_from_learner with integer_number failed');

% read a number from the learner solution
expected_value = 1.2345;
learner_value = RandomParameters.get_number_value_from_learner('decimal_number');
fprintf('%g == %g?\n', expected_value, learner_value);
assert(isequal(learner_value, expected_value), 'get_number_value_from_learner with decimal_number failed');

% read a number from the learner solution
expected_value = -3.4e-6;
learner_value = RandomParameters.get_number_value_from_learner('negative_number');
fprintf('%g == %g?\n', expected_value, learner_value);
assert(isequal(learner_value, expected_value), 'get_number_value_from_learner with negative_number failed');

% read a number from the learner solution
expected_value = 'Hola!';
learner_value = RandomParameters.get_str_value_from_learner('text_value');
fprintf('%s == %s?\n', expected_value, learner_value);
assert(isequal(learner_value, expected_value), 'get_str_value_from_learner with text_value failed');

% read a number from the learner solution
expected_value = 'Hello my dear friend ';
learner_value = RandomParameters.get_str_value_from_learner('another_text_value');
fprintf('%s == %s?\n', expected_value, learner_value);
assert(isequal(learner_value, expected_value), 'get_str_value_from_learner with another_text_value failed');