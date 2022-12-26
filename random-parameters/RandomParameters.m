classdef RandomParameters
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
        function crc = crc32(data)
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
            data = uint8(data);
            % Compute CRC-32 value
            for i = 1:length(data)
                crc = bitxor(crc,uint32(data(i)));
                for j = 1:8
                    mask = bitcmp(bitand(crc,uint32(1)));
                    if mask == intmax('uint32'), mask = 0; else mask = mask+1; end
                    crc = bitxor(bitshift(crc,-1),bitand(poly,mask));
                end
            end
        end

        % https://es.mathworks.com/help/matlab/ref/matlab.unittest.diagnostics.constraintdiagnostic.getdisplayablestring.html
        function str = to_debug_str(anything)
            str = matlab.unittest.diagnostics.ConstraintDiagnostic.getDisplayableString(anything);
        end

        % takes any type of parameters and returns an uint32 integer
        function n = to_uint32(id, salt)
            id_str = RandomParameters.to_debug_str(id);
            salt_str = RandomParameters.to_debug_str(salt);
            n = RandomParameters.crc32([id_str RandomParameters.PEPPER salt_str]);
        end
    end
end