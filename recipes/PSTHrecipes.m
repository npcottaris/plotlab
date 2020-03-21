function theFunctionHandle = PSTHrecipes
     theFunctionHandle = localfunctions;
end

% First external recipe
function firstRecipe(colors)
   % Color order
   set(groot, 'defaultAxesColorOrder', colors);
end

% Second external recipe
function secondRecipe(colors)
   % Color order
   set(groot, 'defaultAxesColorOrder', colors);
   set(groot, 'defaultBarFaceAlpha', 0.4);
   set(groot, 'defaultBarFaceColor', 'flat');
   set(groot, 'defaultBarEdgeAlpha', 0.0);
   set(groot, 'defaultLineLineWidth', 1.5);
end

