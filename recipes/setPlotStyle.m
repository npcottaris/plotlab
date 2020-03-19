function setPlotStyle(lightTheme)

    if (nargin==0)
        lightTheme = 'light';
    end
    
    assert(ischar(lightTheme)&&ismember(lightTheme, {'light', 'dark'}), ...
        'setPlotStyle() argument must be either ''light'' or ''dark''.');
    
    % New plotting params do not go into effect if there are open figures.
    close all;
    
    % Light scheme independent graphics params
    setCommonDefaults();
    
    switch (lightTheme)
        case 'light'
            setLightPlotDefaults();
        case 'dark'
            setDarkPlotDefaults();
    end
end

function setLightPlotDefaults()
% Light-theme related graphics params
    set(groot, 'defaultFigureColor', 0.94*[1 1 1]);
    set(groot, 'defaultAxesColor', [1 1 1]);
    
    set(groot, 'defaultAxesXColor', 0.15*[1 1 1]);
    set(groot, 'defaultAxesYColor', 0.15*[1 1 1]);
    
    defaultAxesColorOrder = get(groot, 'factoryAxesColorOrder');
    defaultAxesColorOrder = cat(1,[0 0 0], defaultAxesColorOrder);
    set(groot, 'defaultAxesColorOrder',defaultAxesColorOrder);
    
    set(groot, 'defaultLineColor', [0.2 0.2 0.2]);
    set(groot, 'defaultLineMarkerEdgeColor', [0.2 0.2 0.2]);
    
    set(groot, 'defaultLineMarkerFaceColor', [1 0.5 0.5]);
    set(groot, 'defaultLineMarkerEdgeColor', [1 0. 0.]);
    
    set(groot, 'defaultScatterMarkerFaceColor', [1 0.5 0.5]);
    set(groot, 'defaultScatterMarkerEdgeColor', [1 0 0]);
    
    set(groot, 'defaultLegendTextColor', [0.1 0.1 0.1]);
    set(groot, 'defaultFigureInvertHardcopy', 'on');   
end


function setDarkPlotDefaults()
% Dark-theme related graphics params

    set(groot, 'defaultFigureColor', 0.1*[1 1 1]);
    set(groot, 'defaultAxesColor', 0.15*[1 1 1]);
    
    set(groot, 'defaultAxesXColor', 0.85*[1 1 1]);
    set(groot, 'defaultAxesYColor', 0.85*[1 1 1]);
    
    defaultAxesColorOrder = get(groot, 'factoryAxesColorOrder');
    defaultAxesColorOrder = cat(1,[0 0 0], defaultAxesColorOrder);
    set(groot, 'defaultAxesColorOrder',1-defaultAxesColorOrder);
    
    set(groot, 'defaultLineColor', [0.8 0.8 0.2]);
    set(groot, 'defaultLineMarkerEdgeColor', [0.8 0.8 0.2]);
    
    set(groot, 'defaultLineMarkerFaceColor', [0.5 1 1]);
    set(groot, 'defaultLineMarkerEdgeColor', [0 1 1]);
    
    set(groot, 'defaultScatterMarkerFaceColor', [0.5 1 1]);
    set(groot, 'defaultScatterMarkerEdgeColor', [0 1 1]);
    
    set(groot, 'defaultLegendTextColor', 1-[0.1 0.1 0.1]);
    set(groot, 'defaultFigureInvertHardcopy', 'off');
end

function setCommonDefaults()

    % Figure
    set(groot, 'defaultFigureRenderer', 'painters');
    set(groot, 'defaultFigureUnits', 'inches');
    set(groot, 'defaultFigurePosition', [0 0 6 4]);
    set(groot, 'defaultAxesUnits', 'inches');
    set(groot, 'defaultAxesOuterPosition', [0.05 0.05 6.0 4.0]);
    set(groot, 'defaultFigurePaperUnits', 'inches');
    set(groot, 'defaultFigurePaperPosition', [0. 0. 6 4]);
    set(groot, 'defaultFigurePaperSize', [6 4]);
    set(groot, 'defaultFigurePaperPositionMode', 'manual');
    
    % Line plot
    set(groot, 'defaultLineLineWidth', 2);
    set(groot, 'defaultLineMarkerSize',12);
    
    % Scatter plot marker
    set(groot, 'defaultScatterMarkerFaceAlpha', 0.5);
    set(groot, 'defaultScatterLineWidth', 1.5);
    
    % Fonts
    set(groot, 'defaultAxesFontSize', 16);
    set(groot, 'defaultAxesFontName', 'Helvetica');
    set(groot, 'defaultAxesTitleFontWeight', 'normal');

    % Ticks
    set(groot, 'defaultAxesTickLength', [0.02 0.01]);
    set(groot, 'defaultAxesTickDir', 'out');
    
    % Grids
    set(groot, 'defaultAxesXGrid', 'on');
    set(groot, 'defaultAxesYGrid', 'on');
    
    % Legend
    set(groot, 'defaultLegendLocation', 'NorthWest');
    
    % Boxes
    set(groot, 'defaultLegendBox', 'off')
    set(groot, 'defaultAxesBox', 'off');
end