function demoLineMarkerPlot()
    
    % Get the data
    [sf, s, c, r, sfModel, sModel, cModel, rModel, b] = getData();
    
    % Set the desired defaults
    plotlab.applyRecipe('',...
        'figureWidthInches', 6, ...
        'figureHeightInches', 5);
    
    % New figure
    hFig = figure(1); clf; hold on;

    % Scatter plots (data)
    scatter(sf,c, 'ro');
    scatter(sf,s, 'bo');
    scatter(sf,r, 'ko');

    % Line plots (model)
    plot(sfModel, cModel, 'r-'); 
    plot(sfModel, sModel, 'b-'); 
    plot(sfModel, rModel, 'k-'); 
    plot(sfModel, b, 'k--');

    % Legend
    legend({'center', 'surround', 'RGC'}, 'Location', 'NorthEast');

    % Title
    title('mRGC');

    % Labels
    xlabel('\it spatial frequency (c/deg)'); ylabel('\it sensitivity');

    set(gca, 'XLim', [0.1 100], 'XTick', [0.1 0.3 1 3 10 30 100], ...
        'YLim', [0 1.5], 'YTick', 0:0.25:1.5, 'XScale', 'log');

    % No box, add grid
    box off; grid on
    
    % Get gallery directory
    p = getpref('plotlab');
    fName = fullfile(p.galleryDir, 'mRGCsf');
    
    % Export to PDF
    print(fName, '-dpdf', '-r300');
    
    % Export to TIFF
    print(hFig, fName, '-dpng', '-r300');
end

function [sf, s, c, r, sfModel, sModel, cModel, rModel, b] = getData()
    sfModel = logspace(log10(0.1), log10(100), 40);
    b = 0.15*ones(size(sfModel));
    sModel = 0.4*exp(-0.5*(sfModel/2).^2) + b;
    cModel = exp(-0.5*(sfModel/10).^2) + b;
    rModel = cModel - sModel + b;
    
    idx = 1:2:numel(sfModel);
    sf = sfModel(idx);
    c = cModel(idx) + 0.03*randn(size(idx));
    s = sModel(idx) + 0.03*randn(size(idx));
    r = rModel(idx) + 0.03*randn(size(idx));
end
