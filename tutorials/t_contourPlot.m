function t_contourPlot
% Generate a contour plot using a private plotlab recipe included in this
% file.
%
% Syntax:
%   t_contourPlot
%
% Description:
%    Demonstrates how to generate a transparent contour plot on top of
%    another plot using a private plotlab recipe.
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
    [coneMosaicStruct, psfStruct] = getData();
    
    % Instantiate a plotlab object
    plotlabOBJ = plotlab();
    
    % Apply the private recipe included in this file
    % using a light-theme and a custom figure size
    plotlabOBJ.applyRecipe(...
        'customRecipeFunction', @privateRecipe, ...
        'lightTheme', 'light', ...
        'figureWidthInches', 5, ...
        'figureHeightInches', 5);
    
    % New figure
    hFig = figure(1); clf; hold on;
    
    % Plot the cone mosaic
    plotConeMosaic(coneMosaicStruct);
    
    % Superimpose a transparent contour plot of the PSF
    % Filled contours are drawn at the zLevels
    zLevels = 0.01:0.01:0.99;
    
    % Line contours are drawn at the outlinedLevels
    outlinedLevels = 0.03:0.1:0.95;
    
    % Filled contours are filled with this color map
    cMap = brewermap(512, 'greys');
    
    % Line contours are drawin in this color
    contourLineColor = [0 0 1];
    
    % Call the specialized contour plot
    plotlabOBJ.transparentContourPlot(gca,...
        psfStruct.xSupport, psfStruct.ySupport,...
        psfStruct.psf, zLevels, outlinedLevels, ...
        contourLineColor, cMap);

    % Axes limits and ticks
    set(gca, 'CLim', [0 1], 'XLim', [-3 3], 'XTick', -3:1:3, ...
        'YLim', [-3 3], 'YTick', -3:1:3);
    
    % Square axis
    axis 'square';
 
    % Labels
    xlabel('\it space (arc min)'); 
    ylabel('\it space (arc min)');
    
    % Title
    title(sprintf('point spread function & cone mosaic'));
    
    % Export the figure to the gallery directory in PNG format
    plotlabOBJ.exportFig(hFig, 'png', 'PointSpreadFunction', 'gallery');
end

function privateRecipe
    set(groot, 'defaultPatchEdgeColor', [0 0 0]);
    set(groot, 'defaultPatchEdgeAlpha',1);
    set(groot, 'defaultPatchFaceAlpha', 0.05);
    set(groot, 'defaultPatchLineStyle', '-');
    set(groot, 'defaultPatchLineWidth', 1.0);
    set(groot, 'defaultAxesTickDir', 'out');
end

function plotConeMosaic(coneMosaicStruct)
    for coneIndex = 1:numel(coneMosaicStruct.coneTypes)
        cp = coneMosaicStruct.coneLocs(coneIndex,:);
        x = cp(1) + coneMosaicStruct.coneApertures(coneIndex)/2*cosd(0:10:360);
        y = cp(2) + coneMosaicStruct.coneApertures(coneIndex)/2*sind(0:10:360);
        switch (coneMosaicStruct.coneTypes(coneIndex))
            case 2
                color = [1 0 0];
            case 3
                color = [0 0.7 0];
            case 4
                color = [0 0 1];
        end
        fill(x,y, color, 'EdgeColor', color, 'FaceAlpha', 0.3);
    end
end

function [coneMosaicStruct, psfStruct] = getData()
    load('mosaicPSFdata', 'coneMosaicStruct', 'psfStruct');
end
 
