function theRecipeFunctionHandles = SurfaceRecipeWithID(recipeID)
% Provide handles to all the recipe functions included in this file
%
% Syntax:
%   externalRecipes = SurfaceRecipes;
%
% Description:
%    Provide handles to all the recipe functions included in this file.
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
% For usage see:
%   t_surfacePlotUsingExternalRecipe()
%

% History:
%    03/25/20  NPC  Wrote it

     theRecipeFunctionHandles = localfunctions;
end

% First recipe
function firstRecipe()

    % Figure properties
    set(groot, 'defaultFigureRenderer', 'painters');
    
    % Surface properties
    set(groot, 'defaultSurfaceEdgeColor', [0.1 0.2 0.5]);
    set(groot, 'defaultSurfaceLineWidth', 0.7);
    set(groot, 'defaultSurfaceFaceAlpha', 1.0);
    set(groot, 'defaultSurfaceFaceLighting', 'gouraud');
    set(groot, 'defaultSurfaceAmbientStrength', 0.9);
    set(groot, 'defaultSurfaceDiffuseStrength', 0.9);
    set(groot, 'defaultSurfaceSpecularStrength', 0.2);
    set(groot, 'defaultSurfaceSpecularExponent', 10);
    set(groot, 'defaultSurfaceMeshStyle', 'both');
    
    % Axes properties
    set(groot, 'defaultAxesProjection', 'perspective')
    set(groot, 'defaultAxesBoxStyle', 'full');
    set(groot, 'defaultAxesFontSize', 18);
    set(groot, 'defaultAxesLineWidth', 1.2);
    %set(groot, 'defaultAxesDataAspectRatio', [1 1 1]);
    %set(groot, 'defaultAxesDataAspectRatioMode', 'manual');
    set(groot, 'defaultAxesPlotBoxAspectRatio', [1 1 0.4]);
    set(groot, 'defaultAxesPlotBoxAspectRatioMode', 'manual');
    set(groot, 'defaultAxesBox', 'on');
    
    % Grids
    set(groot, 'defaultAxesXGrid', 'off');
    set(groot, 'defaultAxesYGrid', 'off');
end