classdef RandomParameters
    methods(Static)
        function str_value = get_str_value_from_learner(param_name)
            % Matlab Grader stores the learner solution in a file named "solution.m"
            learner_solution_file_name = 'solution.m';

            str_value = "";

            lines_from_solution = readlines(learner_solution_file_name);
            % '\s*ID\s*=\s*[\''\"]*(\w+)[\''\"]*';
            pattern = ['\s*' param_name '\s*=\s*[\''\"]*([^\''\"\;]+)[\''\"\;]'];

            for line_number = 1:length(lines_from_solution) 
                line = lines_from_solution{line_number};
                data = regexp(line, pattern, 'tokens');
                if ~isempty(data)
                    % convert from char array to string
                    str_value = string(data{1}{1});
                    break;
                end
            end
        end

        function number_value = get_number_value_from_learner(param_name)
            str_value = RandomParameters.get_str_value_from_learner(param_name);
            % str2double returns NaN if it isn't possible to convert the str
            number_value = str2double(str_value);
        end
    end
    properties
        random_stream;
    end
    methods
        function obj = RandomParameters(id, salt)
            seed = RandomParameters.to_uint32(id, salt);
            obj.random_stream = RandStream('mt19937ar','Seed', seed);
        end

        function value = get_double_between(obj, a, b, d)
            r1 = rand(obj.random_stream,1);
            r2 = (b-a)*r1 + a;
            value = round(r2, d);
        end

        function value = get_int_between(obj, a, b)
            value = randi(obj.random_stream, [a,b], 1);
        end

        function value = get_from_cell_array(obj, cell_array)
            n = obj.get_int_between(1, length(cell_array));
            value = cell_array{n};
        end
    end
    properties (Constant, Access = private)
        PEPPER = '\nX!S&WOQeojB€@xFJAZXfSzD4SH0VbLK7ñr1alkbUÇf=Ou$iu\n';
    end
    methods(Static, Access = private)
        % https://es.mathworks.com/matlabcentral/fileexchange/49518-crc-32-computation-algorithm
        function crc = crc32(char_array)
            %crc32   Computes the CRC-32 checksum value of a byte vector.
            %--------------------------------------------------------------------------
            %   CRC = crc32(DATA) computes the CRC-32 checksum value of the data stored
            %   in vector DATA. The elements of DATA are interpreted as unsigned bytes
            %   (uint8). The result is an unsigned 32-bit integer (uint32). Polynomial
            %   bit positions have been reversed, and the algorithm modified, in order
            %   to improve performance.
            %   Version:    1.00
            %   Programmer: Costas Vlachos
            %   Date:       23-Dec-2014
            % Initialize variables
            crc  = uint32(hex2dec('FFFFFFFF'));
            poly = uint32(hex2dec('EDB88320'));
            data = uint8(char_array);
            % Compute CRC-32 value
            for i = 1:length(data)
                crc = bitxor(crc,uint32(data(i)));
                for j = 1:8
                    mask = bitcmp(bitand(crc,uint32(1)));
                    if mask == intmax('uint32')
                        mask = 0;
                    else 
                        mask = mask+1;
                    end
                    crc = bitxor(bitshift(crc,-1),bitand(poly,mask));
                end
            end
        end
        
        function char_array = to_char_array(anything)
            % https://es.mathworks.com/help/rptgen/ug/mlreportgen.utils.tostring.html
            str = mlreportgen.utils.toString(anything);
            char_array = char(str);
        end

        % takes any type of parameters and returns an uint32 integer
        function n = to_uint32(id, salt)
            id_char_array = RandomParameters.to_char_array(id);
            salt_char_array = RandomParameters.to_char_array(salt);
            % with a char array of the id + pepper + salt, an uint32 number is created
            n = RandomParameters.crc32([id_char_array RandomParameters.PEPPER salt_char_array]);
        end
    end
end