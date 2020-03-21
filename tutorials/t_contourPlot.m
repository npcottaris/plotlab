function t_contourPlot
    [coneMosaicStruct, psfStruct] = getData();
    
    plotlab.applyRecipe(...
        'customRecipeFunction', @privateRecipe, ...
        'figureWidthInches', 6.2, ...
        'figureHeightInches', 6.2);
    
    % New figure
    hFig = figure(1); clf; hold on;
    
    % Plot the cone mosaic
    plotConeMosaic(coneMosaicStruct);
    
    % Superimpose a transparent contour plot of the PSF
    zLevels = 0.01:0.01:0.99;
    outlinedLevels = 0.05:0.1:0.95;
    cMap = brewermap(512, 'greys');
    
    plotlab.transparentContourPlot(gca,...
        psfStruct.xSupport, psfStruct.ySupport,...
        psfStruct.psf, zLevels, outlinedLevels, cMap);
    
    % Title
    title(sprintf('point spread function & cone mosaic'));

    % Labels
    xlabel('\it space (arc min)'); 
    ylabel('\it space (arc min)'); 

    set(gca, 'CLim', [0 1], 'XLim', [-3 3], 'XTick', -3:1:3, ...
        'YLim', [-3 3], 'YTick', -3:1:3);
    
    % Square axis
    axis 'square';
 
    % Export the figure to the gallery directory in PNG format
    plotlab.exportFig(hFig, 'png', 'PointSpreadFunction', 'gallery');
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
 
