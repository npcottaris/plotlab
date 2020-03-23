function t_histogramPlotUsingExternalRecipe()
% Generate a bar plot using an external plotlab recipe.
%
% Syntax:
%   t_histogramPlotUsingExternalRecipe
%
% Description:
%    Demonstrates how to generate a bar plot using a custom external recipe
%    which modifies the default recipe. Also shows how to pass arguments to
%    the external recipe. Additionally, we show how to further modify the
%    bar plot by plotting an outline and by offsetting the x- and y-axes.
%
% Inputs:
%    None.
%
% Outputs:
%    None.
%
% Optional key/value pairs:
%    None.
%

% History:
%    03/21/20  NPC  Wrote it

    % Get the demo data to plot
    [time, neuron1PSTH, neuron2PSTH] = getData();
    
    % Colors to use for the two histograms
    neuronColors = [0.3 0.3 0.5; 1 0.2 0.2];
    
    % Apply one of the receipes located in file 'PSTHrecipe.m'
    externalRecipes = PSTHrecipes;
    
    % Let's go with the second recipe
    whichExternalRecipe = externalRecipes{2};
    
    % Instantiate a plotlab object
    plotlabOBJ = plotlab();
    
    % Apply the external recipe with the desired neurons colors 
    % using a light-theme and specify a custom figure size
    plotlabOBJ.applyRecipe(...
        'customRecipeFunction', @()whichExternalRecipe(neuronColors), ...
        'lightTheme', 'light', ...
        'figureWidthInches', 6, ...
        'figureHeightInches', 5);
    
    % New figure
    hFig = figure(1); clf;
    
    % Bar plots for the histograms
    bar(time,  neuron1PSTH, 1); hold on
    bar(time,  neuron2PSTH, 1);
    
    % Outline the bars for a nice effect
    plotlab.barOutline(time, neuron1PSTH);
    plotlab.barOutline(time, neuron2PSTH);
    
    % Axes limits and ticks  
    set(gca, 'XLim', [0 500], 'XTick', 0:100:500, ...
        'YLim', [-50 125], 'YTick', -50:25:200);
    
    % Offset the axes 
    plotlab.offsetAxes(gca);
    box 'off';
    
    % Labels
    xlabel('\it time (msec)'); ylabel('\it diff. response (spikes/sec)');
    
    % Legend
    legend({'neuron-A', 'neuron-B'}, 'Location', 'NorthEast');

    % Title
    title(sprintf('neurons in temporal quadrature'));
 
    % Export the figure to the gallery directory in PNG format
    plotlabOBJ.exportFig(hFig, 'png', 'PSTHhistogram', 'gallery');
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
    % Set the random seed
    rng(1);
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
