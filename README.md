# plotlab
## Automatic generation of visually-engaging Matlab plots 

```plotlab``` is a toolbox for the automatic generation of publication quality Matlab plots. The approach followed is to define 'recipes' which override various default plotting properties of the Matlab graphics root object, so as to generate plot that:
- are visually-engaging, 
- are publication-ready,
- have a consistent appearance across operating systems (mac/linux) and graphics formats (vector/raster).

This approach minimizes the classic paradigm of repeatedly entering boilerplate code for setting various plotting options to one's liking. `Plotlab` includes several tutorials that show different ways of setting default parameters for a number of plot types.

## The problem addressed
The left column in the table below depicts a simple MATLAB snippet used to generate a line/marker combo plot. The right column depicts the plot generated using this code. There are two main issues with this, and, in general, with all the default MATLAB plots: 
- illegibility, due to the small font size, the small symbol size, line thickness, etc, and,
- an overall lack of visual appeal

<table bgcolor=>
<tr>
<th> Matlab code </th>
<th> Rendered output </th>
<tr>
<td>
<pre lang="matlab">
% --- Generic plotting code begins ---
%
% New figure
hFig = figure(1); clf; hold on;
%
% Scatter plots (data)
scatter(sf,c, 'ro');
scatter(sf,s, 'bo');
scatter(sf,r, 'ko');
%
% Line plots (model)
plot(sfModel, cModel, 'r-'); 
plot(sfModel, sModel, 'b-'); 
plot(sfModel, rModel, 'k-'); 
plot(sfModel, b, 'k--');
%
% Legend
legend({'center', 'surround', 'RGC'}, ...
 'Location', 'NorthEast');
%
% Title
title('mRGC');
%
% Labels
xlabel('\it spatial frequency (c/deg)'); 
ylabel('\it sensitivity');
%
set(gca, 'XLim', [0.1 100], ,...
 'XTick', [0.1 0.3 1 3 10 30 100], ...
 'YLim', [0 1.5], 'YTick', 0:0.25:1.5, ...
 'XScale', 'log');
%
% --- Generic plotting code ends ---
%
</pre>
</td>
<td>
  <img src="assets/demoPlots/defaultPlot.png" width="450" />
</td>
</table>

## The plotlab solution
`plotlab` contains functionality that is engaged before issuing any Matlab plotting commands and which overrides plotting parameters from their factory settings to the settings preferred by the user so as to achieve a preferred look. This is done by calling the `plotlab.applyRecipe()` method. The new plotting parameters are in effect for the current Matlab session, or until the user issues a new call to the `applyRecipe()` method. The overriden plotting parameters are erased once the user exits the current Matlab session.

There are 3 different ways that the user can override the plotting parameter values set by `applyRecipe()`:
1. by passing key-value pair arguments in the `applyRecipe()` method. This is a good choice if the user likes most of the choices in `plotlab`s default recipe and only wishes to modify a few individual parameters.
2. by passing a function handle to a private recipe that is included in the user's script
3. by passing a function handle to one of the recipe files included in `plotlab`'s `recipes` directory. A recipe file can include several recipe functions and the user can select which one to apply.

In the table below, override method no. 1 is used, thereby accepting the default `plotlab` recipe and only overriding the figure size. The resulting plot is depicted in the right column. Comparison to Matlab's default plot (depicted in the table above) shows the drastic enhancement in visual appeal and legibility offered by the default recipe of `plotlab`.

<table>
<tr>
<th> Matlab code </th>
<th> Rendered output </th>
<tr>
<td>
<pre lang="matlab">
% Apply a desired plotlab recipe
plotlab.applyRecipe(...
  'figureWidthInches', 6, ...
  'figureHeightInches', 5);
%    
% --- Generic plotting code begins ---
%               ...
% --- Generic plotting code ends ---
%
</pre>
</td>
<td>
  <img src="assets/demoPlots/mRGCsf.png" width="450" />
</td>
</table>

Completely customized plots can be obtained by using overriding methods no. 2 and no. 3, which pass recipe function handles to the `applyRecipe()` method. In override method no. 2, the user codes a private recipe as an internal function in the same script as the plotting code. This can be a good option if the user does not want to include the recipe in the `recipes` directory, or if the particular recipe is only used once. In override method no. 3, the user selects one of the available pre-configured recipes in the `recipes` directory. Users can add their own recipes in the `recipes`  directory for repeated use in different scripts and/or for sharing with other users.

The code below shows an example of how to use an external recipe, here the second recipe contained in the `\recipes\PSTHrecipe.m` file.

```
% Apply one of the receipes located in file 'PSTHrecipe.m'
externalRecipes = PSTHrecipes;
    
% Let's go with the second recipe
whichExternalRecipe = externalRecipes{2};
    
% How to color the neuron responses. This
% matrix is passed as an input argument to
% the external recipe.
neuronColors = [...
   0.3 0.3 0.5; ...  % neuron 1 in gray
   1 0.2 0.2 ...     % neuron 2 in pinkish-red
   ];
   
% Apply the chosen recipe passing the neuronColors as input argument
plotlab.applyRecipe(...
   'customRecipeFunction', @()whichExternalRecipe(neuronColors), ...
   'figureWidthInches', 6, ...
   'figureHeightInches', 5);
 ```

# Tutorials
The `tutorials` directory contains tutorials that show different ways of using `plotlab` to enhance a variety of plot types. 

# Additional capabilities
`plotlab` also contains plotting scipts for generating more complex plot types. These are static method in the `@plotlab` object.

## plotlab gallery

The table below depicts a collection of plots generated by various recipes of `plotlab`. The generating tutorial scripts are shown on top of each plot.
<table bgcolor=>
<tr>
 <td> <pre> tutorials/demoLineMarkerPlot.m </pre> </td>
 <td> <pre> tutorials/demoAreaPlot.m </pre> </td>
<tr>
 <td> <img src="assets/demoPlots/mRGCsf.png" width="450" /> </td>
 <td> <img src="assets/demoPlots/SSnomograms.png" width="450" /> </td>
 <tr>
 <td> <pre> tutorials/demoAreaPlotWithInternalRecipe.m </pre> </td>
 <td> <pre> tutorials/demoHistogramPlotWithExternalRecipe.m </pre> </td>
  <tr>
 <td> <img src="assets/demoPlots/RFprofile.png" width="450" /> </td>
 <td> <img src="assets/demoPlots/PSTHhistogram.png" width="450" /> </td>
</table>
