% Test file for @chebfun/subspace.m.

function pass = test_subspace(pref)

if ( nargin == 0 )
   pref = chebfun.pref(); 
end

% Orthonormal array-valued chebfun:
A = chebfun(@(t) [1/sqrt(2)+0*t cos(t) sin(2*t) sin(3*t)]/sqrt(pi), ...
    [0 1 2*pi], pref);

f = chebfun(@(t) sin(10*t)/sqrt(pi), [0 2 2*pi], pref);
alpha = [1e-10 pi/5 pi/2-1e-10];

for k = 1:length(alpha)
    B = cos(alpha(k))*A(:,k) + sin(alpha(k))*f;
    angle = subspace(A, B);
    pass(k) = abs(angle - alpha(k)) < 1e3*epslevel(B);
end

end
