classdef LatexPlot
    properties (Constant, Access = private)
        DEFAULT_FONT_COLOR = 'k'; % black
        DEFAULT_BACKGROUND_COLOR = '#FFFFE0'; % yellow
        DEFAULT_FONT_SIZE = 14;
    end
    methods(Static)
        % max 8 lines
        function show(lines, varargin)
            p = inputParser;
            addOptional(p, 'FontColor', LatexPlot.DEFAULT_FONT_COLOR);
            addOptional(p, 'FontSize', LatexPlot.DEFAULT_FONT_SIZE);
            addOptional(p, 'BackgroundColor', LatexPlot.DEFAULT_BACKGROUND_COLOR);
            parse(p, varargin{:});

            figure;
            axis off;
            x = -0.1;
            y = 1;
            for n = 1:length(lines)
                line = lines{n};
                text(x, y, line, 'Interpreter', 'Latex', 'FontSize', p.Results.FontSize, 'Color', p.Results.FontColor);
                y = y - 0.15;
            end
            set(gcf,'color',p.Results.BackgroundColor);
            hold off;
        end
    end
end