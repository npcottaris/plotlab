# plotlab
A toolbox for the automatic generation of publication quality Matlab plots

Scientific plots generated via the default plot settings in Matlab are un-appealing and quite illegible.
The plotlab toolbox changes the default plot settings so as to render plots that are visually-engaging, publication-ready, and consistent across computing platforms (mac and linux) and across graphics formats. 

<table bgcolor=>
<tr>
<th> Matlab code </th>
<th> Rendered output </th>
<tr>
<td>
<pre lang="matlab">
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
</pre>
</td>
<td>
  <img src="assets/demoPlotDefault.png" width="450" />
</td>
</table>
   
<table>
<tr>
<th> Matlab code </th>
<th> Rendered output </th>
<tr>
<td>
<pre lang="matlab">
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
</pre>
</td>
<td>
  <img src="assets/demoPlot.png" width="450" />
</td>
</table>


| default plot  | plotlab plot|
| ------------- | ------------- |
|  ![](assets/plotcode.png = 250x250) | ![](assets/demoPlotDefault.png)|
| --------- | ![](assets/demoPlot.png)  |

