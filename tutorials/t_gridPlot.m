function t_gridPlot()
% Generate a figure consisting of an array of plots.
%
% Syntax:
%   t_gridPlot
%
% Description:
%    Generate a figure consisting of an array of plots 
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
    [RGBimage, LSMcontrasts, spatialSupport] = getData();
    
    % Instantiate a plotlab object
    plotlabOBJ = plotlab();
    
    % Apply the default plotlab recipe overriding 
    % just the figure size
    plotlabOBJ.applyRecipe(...
        'axesTickDir', 'in', ...
        'figureWidthInches', 10, ...
        'figureHeightInches', 9);
    
    % New figure
    hFig = figure(1); clf;

    % Generate axes in a [2x2] layout
    theAxesGrid = plotlab.axesGrid(hFig, ...
        'rowsNum', 2, 'colsNum', 2, ...
        'spacing', 'normal', ...
        'padding', 'normal', ...
        'method', 'tile');
    
    % Colormap
    cmap = brewermap(1024, 'RdBu');
    
    for row = 1:2
        for col = 1:2
            
            theCurrentAxes = theAxesGrid{row,col};
            idx = (row-1)*2+col;
            if (idx < 4)
                imagesc(theCurrentAxes, spatialSupport, spatialSupport, squeeze(LSMcontrasts(:,:,idx)));
            else
                image(theCurrentAxes, spatialSupport, spatialSupport, RGBimage);
            end
            % Plot the cross hairs
            plotlab.crossHairs2D(theCurrentAxes, ...
                'xRange', [-2 2], 'yRange', [-2 2]);

            axis(theCurrentAxes, 'square');
            set(theCurrentAxes, 'XTick', [], 'YTick', []);
            switch (idx)
                case 1
                    title(theCurrentAxes, 'L-cone contrast');
                    colormap(theCurrentAxes, cmap);
                    CLim = [-0.2 0.2];
                    colorbarTicks = -0.2:0.05:0.2;
                    colorbarTickLabels = {'-.20','-.15','-.10','-.05','0','+.05','+.10','+.15', '+.20 '};
                case 2
                    title(theCurrentAxes, 'M-cone contrast');
                    colormap(theCurrentAxes, cmap);
                    CLim = [-0.2 0.2];
                    colorbarTicks = -0.2:0.05:0.2;
                    colorbarTickLabels = {'-.20','-.15','-.10','-.05','0','+.05','+.10','+.15', '+.20 '};
                case 3
                    title(theCurrentAxes, 'S-cone contrast');
                    colormap(theCurrentAxes, cmap);
                    CLim = [-1 1];
                    colorbarTicks = -1:0.25:1;
                    colorbarTickLabels = {'-1.0','-.75','-.50','-.25','0','+.25','+.50','+.75', '+1.0 '};
                case 4
                    title(theCurrentAxes, 'RGB image');
            end

            if (idx < 4)
                %    Add colorbar without resizing the figure
                plotlab.colorbar(theCurrentAxes,'', 16, ...
                    'Location','eastoutside' ,...
                    'Ticks',colorbarTicks,'TickLabels',colorbarTickLabels);
            end
            
            % Axes limits and ticks
            set(theCurrentAxes, 'XLim', [-1.9 2], 'XTick', [-2:0.5:2], ...
                'YLim', [-2 2], 'YTick', -2:0.5:2, 'CLim', CLim);

            % Labels
            if (row == 2)
                xlabel(theCurrentAxes,'\it space (degs)'); 
            else
                set(theCurrentAxes, 'XTickLabel', {});
            end
            if (col == 1)
                ylabel(theCurrentAxes,'\it space (degs)');
            else
                set(theCurrentAxes, 'YTickLabel', {});
            end
        end
    end
        
    % Export the figure to the gallery directory in PNG format
    plotlabOBJ.exportFig(hFig, 'png', 'coneContrastImageComponents', 'gallery');
end

function  [RGBimage, LSMcontrasts, spatialSupport] = getData()
    load('LMScomponentRGBimage', 'RGBimage', 'LSMcontrasts', 'spatialSupport');
end
