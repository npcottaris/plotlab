function demoAreaPlot

    [L_absorbance, M_absorbance, S_absorbance, lambda] = getData();
    
    LMSconeColors = [1 0.2 0.4; ...
                0.1 1 0.4; ...
                0.5 0.1 0.8];
            
    % Set the desired defaults
    plotlab.applyRecipe('',...
        'colorOrder', LMSconeColors, ...
        'figureWidthInches', 6, ...
        'figureHeightInches', 6);
    
    % New figure
    hFig = figure(1); clf; hold on;

    % Area plots (data)
    minAbsorbance = 0.01;
    area(lambda, L_absorbance, minAbsorbance);
    area(lambda, M_absorbance, minAbsorbance);
    area(lambda, S_absorbance, minAbsorbance);
    
    % Legend
    legend({'L cone', 'M cone', 'S cone'}, 'Location', 'NorthEast');

    % Title
    title(sprintf('Stockman-Sharpe nomograms'));

    % Labels
    xlabel('\it wavelength (nm)'); ylabel('\it normalized absorbance');

    set(gca, 'XLim', [400 700], 'XTick', 350:50:850, ...
        'YLim', [minAbsorbance 1.0], 'YTick', [0.01 0.03 0.1 0.3 1], 'YScale', 'log')
    
    % No box, add grid
    box off; grid on
    

    % Get gallery directory
    p = getpref('plotlab');
    fName = fullfile(p.galleryDir, 'SSnomograms');
    
    % Export to PDF
    print(hFig, fName, '-dpdf', '-r300');
    
    % Export to TIFF
    print(hFig, fName, '-dpng', '-r300');
end

function [L_absorbance, M_absorbance, S_absorbance, lambda] = getData()
    S = [350 2 200];
    lambda = SToWls(S);
    lambdaPeak = [420.7 530.3  558.9];
    S_absorbance = StockmanSharpeNomogram(S,lambdaPeak(1));
    M_absorbance = StockmanSharpeNomogram(S,lambdaPeak(2));
    L_absorbance = StockmanSharpeNomogram(S,lambdaPeak(3));
end