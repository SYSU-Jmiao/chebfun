function pass = test_schrodinger( prefs )
% Check constant coefficient schrodinger equation. 

if ( nargin < 1 ) 
    prefs = chebfunpref(); 
end 
tol = prefs.cheb2Prefs.eps; 

% w > V
V = 1;  %potential function 
w = 2;  % frequency
k = sqrt(w - V); % wave number by dispersion relation
d = [-10 10 0 1];
exact = chebfun2(@(x, t) exp(1i*(k*x-w*t)), d);
N = chebop2(@(u) 1i*diff(u,1,1) + diff(u,2,2) - V*u, d); 
N.lbc = exact(d(1),:); N.rbc = exact(d(2),:);
% N.dbc = chebfun(@(x) exp(-10*(x-.2).^2),d(1:2));   %wave packet.
N.dbc = exact(:,d(3));
u = N \ 0; 

pass(1) = ( norm(u - exact) <tol ); 

% Superposition
% w > V
V = 1;  %potential function 
w = 2;  % frequency
k = sqrt(w - V); % wave number by dispersion relation
d = [-10 10 0 1];
exact = chebfun2(@(x, t) exp(1i*(k*x-w*t)) + exp(1i*(-k*x-w*t)), d);
N = chebop2(@(u) 1i*diff(u,1,1) + diff(u,2,2) - V*u, d); 
N.lbc = exact(d(1),:); N.rbc = exact(d(2),:);
% N.dbc = chebfun(@(x) exp(-10*(x-.2).^2),d(1:2));   %wave packet.
N.dbc = exact(:,d(3));
u = N \ 0; 

pass(2) = ( norm(u - exact) <tol ); 


% w < V

V = 2;  %potential function 
w = 1;  % frequency
k = sqrt(w - V); % wave number by dispersion relation
d = [-1 1 0 1];
exact = chebfun2(@(x, t) exp(1i*(k*x-w*t)), d);
N = chebop2(@(u) 1i*diff(u,1,1) + diff(u,2,2) - V*u, d); 
N.lbc = exact(d(1),:); N.rbc = exact(d(2),:);
% N.dbc = chebfun(@(x) exp(-10*(x-.2).^2),d(1:2));   %wave packet.
N.dbc = exact(:,d(3));
u = N \ 0; 

pass(3) = ( norm(u - exact) <tol );

end 