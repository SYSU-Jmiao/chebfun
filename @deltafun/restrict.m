function g = restrict(f, s)
%RESTRICT   Restrict a DELTAFUN to a subinterval.
%   RESCTRICT(F, S) returns a DELTAFUN that is restricted to the subinterval
%   [S(1), S(2)] of the domain of F.
%
%   If length(S) > 2, i.e., S = [S1, S2, S3, ...], then RESCTRICT(F, S) returns
%   an array of DELTAFUN objects, where the entries hold F restricted to each of
%   the subintervals defined by S.

% Copyright 2014 by The University of Oxford and The Chebfun Developers.
% See http://www.chebfun.org/ for Chebfun information.

% Deal with empty case:
if ( isempty(f) )
    g = f;
    return
end

% Get the domain:
dom = domain(f);
a = dom(1); 
b = dom(2);

% Check if s is actually a subinterval:
if ( (s(1) < a) || (s(end) > b) || (any(diff(s) <= 0)) )
    error('DELTAFUN:restrict:badinterval', 'Not a valid subinterval.')
elseif ( (numel(s) == 2) && all(s == [a, b]) )
    % Nothing to do here!
    return
end

% Restrict the funPart:
restrictedFunParts = restrict(f.funPart, s);
if ( ~iscell(restrictedFunParts) )
    restrictedFunParts = {restrictedFunParts};
end

% Create a cell to be returned.
g = cell(1, numel(s)-1);

% Loop over each of the new subintervals, make a DELTAFUN and store in a cell:
for k = 1:(numel(s) - 1)
    funPart = restrictedFunParts{k};

    idx = (f.deltaLoc >= s(k)) & (f.deltaLoc <= s(k+1));
    deltaLoc = f.deltaLoc(idx);
    deltaMag = f.deltaMag(:,idx);

    if ( isempty(deltaLoc) )
        deltaLoc = [];
        deltaMag = [];
    end

    % Construct the new deltafun:
    if ( isempty(deltaLoc) )
        g{k} = funPart;
    else
        g{k} = deltafun(funPart, deltaMag, deltaLoc);
    end
end

% Return a DELTAFUN or CLASSICFUN if only one subinterval is requested:
if ( numel(s) == 2 )
    g = g{1};
end


end