classdef LatexPlot
    properties (Constant, Access = private)
        DEFAULT_FONT_COLOR = 'k'; % black
        DEFAULT_BACKGROUND_COLOR = '#FFFFE0'; % yellow
        DEFAULT_FONT_SIZE = 14;
    end
    methods(Static)
        % max 8 lines
        function show(lines)
            font_color = LatexPlot.DEFAULT_FONT_COLOR;
            font_size = LatexPlot.DEFAULT_FONT_SIZE;
            background_color = LatexPlot.DEFAULT_BACKGROUND_COLOR;

            figure;
            axis off;
            x = -0.1;
            y = 1;
            for n = 1:length(lines)
                line = lines{n};
                text(x, y, line, 'Interpreter', 'Latex', 'FontSize', font_size, 'Color', font_color);
                y = y - 0.15;
            end
            set(gcf,'color',background_color);
            hold off;
        end
    end
end