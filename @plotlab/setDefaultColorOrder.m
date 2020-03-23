function setDefaultColorOrder(varargin)
% Set the colors for sequentials plots
%
% Syntax:
%   setDefaultColorOrder(varargin)
%
% Description:
%    Set the colors for sequentials plots.
%
% Inputs:
%    None.
%
% Outputs:
%    None.
%
% Optional key/value pairs:
%    'rgbColors'   - an [N x 3] matrix specifying the RGB colors of N
%                    sequential plots.
%

% History:
%    03/21/20  NPC  Wrote it

    p = inputParser;
    p.addParameter('rgbColors', [0 0 0], @(x) (isnumeric(x))&&(size(x,2)==3));
    p.parse(varargin{:});
    
    if (size(p.Results.rgbColors,1) == 1)
        defaultAxesColorOrder = get(groot, 'factoryAxesColorOrder');
        defaultAxesColorOrder = cat(1,p.Results.rgbColors, defaultAxesColorOrder);
        set(groot, 'defaultAxesColorOrder',defaultAxesColorOrder);
    else
        set(groot, 'defaultAxesColorOrder',p.Results.rgbColors);
    end
    
end

