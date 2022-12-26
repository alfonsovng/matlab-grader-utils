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
