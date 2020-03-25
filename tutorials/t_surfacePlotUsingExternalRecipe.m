function t_surfacePlotUsingExternalRecipe
% Generate a surface 3D plot using an external plotlab recipe.
%
% Syntax:
%   t_surfacePlotUsingExternalRecipe
%
% Description:
%    Demonstrates how to generate a 3D surface plot using an external recipe
%    Also shows how to pass arguments to
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
    [time, space, xtRF] = getData();
    [X,T] = meshgrid(space, time);
    
    % Apply one of the receipes located in file 'PSTHrecipe.m'
    externalRecipes = SurfaceRecipes;
    
    % Let's go with the second recipe
    whichExternalRecipe = externalRecipes{1};
    
    % Instantiate a plotlab object
    plotlabOBJ = plotlab();
    
    % Apply the external recipe
    plotlabOBJ.applyRecipe(...
        'customRecipeFunction', whichExternalRecipe, ...
        'lightTheme', 'light', ...
        'figureWidthInches', 8, ...
        'figureHeightInches', 5);
    
    % New figure
    hFig = figure(1); clf; hold on;
    
    % Plot the surface
    surface(X,T,xtRF);
    
    % Set the view angle and the light angle
    view([-126 20]);
    lightangle(180, 30);
    
    % Title
    title(sprintf('spatiotemporal receptive field'));
    
    % Labels, tick rotation and view
    % Note: the rotation of the axes labels depends n the view angle as
    % well as the box aspect ratio.
    xlabel('\it space (degrees)', 'rotation', -30); 
    ylabel('\it time (seconds)', 'rotation', 17); 
    zlabel('\it response', 'rotation', 92);
    
    % Colormap
    colormap(brewermap(512, '*greys'))
    
    % Clim
    set(gca, 'ZLim', [min(xtRF(:)) max(xtRF(:))], 'CLim', max(xtRF(:))*[-1 1], ...
        'XLim', [-1 1],'XTick', -1:0.5:1, ...
        'YLim', [0 0.3], 'YTick', 0:0.1:0.5, ...
        'ZTick', []);
    
    % Export the figure to the gallery directory in PNG format
    plotlabOBJ.exportFig(hFig, 'png', 'xtRF', 'gallery');
end



function [time, space, xtRF] = getData()
    N = 80; T = 0.3; dt = T/N;
    time = 0:dt:T;

    % Temporal params
    tau = 0.015; 
    n1 = 6; n2 = 9; gain = 0.9;

    % Temporal impulse response
    centerIR = (time/tau).^n1 .* exp(-time/tau).*(1/factorial(n1) - gain*((time/tau).^2)/factorial(n1+2));
    surroundIR = (time/tau).^n2 .* exp(-time/tau).*(1/factorial(n2) - gain*((time/tau).^2)/factorial(n2+2));

    % Spatial params
    space = -1:0.01:1;
    sigma = 0.08;
    
    % Spatial RFs
    surroundRF = exp(-0.5*(space/(sigma*6)).^2);
    centerRF = exp(-0.5*(space/sigma).^2);

    % Spatiotemporal RFs
    xtCenter = (centerIR)' * centerRF;
    xtSurround = (surroundIR)' * surroundRF;
    xtRF = xtCenter-0.25*xtSurround;
    xtRF = xtRF / max(abs(xtRF(:)));
    
    % Subsample
    skipT = 2; skipX = 3;
    time = time(1:skipT:end);
    space = space(1:skipX:end);
    xtRF= 100*xtRF(1:skipT:end, 1:skipX:end);
end
 
