function theRecipeFunctionHandles = PSTHrecipes
% Provide handles to all the recipe functions included in this file
%
% Syntax:
%   externalRecipes = PSTHrecipes;
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
%   t_histogramPlotUsingExternalRecipe()
%

% History:
%    03/21/20  NPC  Wrote it

     theRecipeFunctionHandles = localfunctions;
end

% First external recipe. Only setting the color order
function firstRecipe(colors)
   % Color order
   set(groot, 'defaultAxesColorOrder', colors);
end

% Second external recipe. Setting the color order and a number of bar plot
% specific and other plotting options
function secondRecipe(colors)
   % Color order
   set(groot, 'defaultAxesColorOrder', colors);
   set(groot, 'defaultBarFaceAlpha', 0.4);
   set(groot, 'defaultBarFaceColor', 'flat');
   set(groot, 'defaultBarEdgeAlpha', 0.0);
   set(groot, 'defaultLineLineWidth', 1.5);
   set(groot, 'defaultAxesTickDir', 'in');
end

