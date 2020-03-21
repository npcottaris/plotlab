function t_histogramPlotUsingExternalRecipe()

    % Get the data
    [time, neuron1PSTH, neuron2PSTH] = getData();
    
    % Colors to use for the two histograms
    neuronColors = [0.3 0.3 0.5; 1 0.2 0.2];
    
    % Apply one of the receipes located in file 'PSTHrecipe.m'
    externalRecipes = PSTHrecipes;
    
    % Let's go with the second recipe
    whichExternalRecipe = externalRecipes{2};
    
    % Apply that recipe
    plotlab.applyRecipe(...
        'customRecipeFunction', @()whichExternalRecipe(neuronColors), ...
        'figureWidthInches', 6, ...
        'figureHeightInches', 5);
    
    % New figure
    hFig = figure(1); clf;
    bar(time,  neuron1PSTH, 1); hold on
    bar(time,  neuron2PSTH, 1);
    plotlab.barOutline(time, neuron1PSTH);
    plotlab.barOutline(time, neuron2PSTH);
    
    % Legend
    legend({'neuron-A', 'neuron-B'}, 'Location', 'NorthEast');

    % Title
    title(sprintf('neurons in temporal quadrature'));

    % Labels
    xlabel('\it time (msec)'); ylabel('\it diff. response (spikes/sec)');

    set(gca, 'XLim', [0 500], 'XTick', 0:100:500, ...
        'YLim', [-50 125], 'YTick', [-50:25:200]);
    % No box, add grid
    box off; grid on
    
    % Offset the axes 
    plotlab.offsetAxes(gca);
    
    
    % Get gallery directory
    p = getpref('plotlab');
    fName = fullfile(p.galleryDir, 'PSTHhistogram');
    
    % Export to PDF
    print(hFig, fName, '-dpdf', '-r300');
    
    % Export to PNG
    print(hFig, fName, '-dpng', '-r300');
    
end

function [time, neuron1PSTH, neuron2PSTH] = getData()
    N = 50;
    T = 0.5;
    dt = T/N;
    time = 0:dt:T;

    % Temporal filter parameters
    tau = 0.015; 
    n1 = 6;
    n2 = 9;
    gain = 0.9;
    % Temporal filter response
    ir1 = (time/tau).^n1 .* exp(-time/tau).*(1/factorial(n1) - gain*((time/tau).^2)/factorial(n1+2));
    ir2 = (time/tau).^n2 .* exp(-time/tau).*(1/factorial(n2) - gain*((time/tau).^2)/factorial(n2+2));
    maxIR = max([max(abs(ir1)) max(abs(ir2))]);
    ir1 = ir1 / maxIR;
    ir2 = ir2 / maxIR;

    neuron1PSTH = 100*(ir1 + 0.03*randn(size(ir1)));
    neuron2PSTH = 100*(ir2 + 0.03*randn(size(ir2)));
    time = time * 1000;

end
