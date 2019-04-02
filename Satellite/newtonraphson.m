function [x, resnorm, F,output] = newtonraphson(fun, x0, options)

%     F= residual Function value

%% initialize
% There are no argument checks!
x0 = x0(:); % needs to be a column vector
% set default options
oldopts = optimset( ...
    'TolX', 1e-12, 'TolFun', 1e-6, 'MaxIter', 100, 'Display', 'iter');
if nargin<3
    options = oldopts; % use defaults
else
    options = optimset(oldopts, options); % update default with user options
end
FUN = @(x)funwrapper(fun, x); % wrap FUN so it always returns J
%% get options
TOLX = optimget(options, 'TolX'); % relative max step tolerance
TOLFUN = optimget(options, 'TolFun'); % function tolerance
MAXITER = optimget(options, 'MaxIter'); % max number of iterations

TYPX = max(abs(x0), 1); % x scaling value, remove zeros
ALPHA = 1e-4; % criteria for decrease
MIN_LAMBDA = 0.1; % min lambda
MAX_LAMBDA = 0.5; % max lambda
%% set scaling values
% TODO: let user set weights
weight = ones(numel(FUN(x0)),1);
J0 = weight*(1./TYPX'); % Jacobian scaling matrix

%% check initial guess
x = x0; % initial guess
[F, J] = FUN(x); % evaluate initial guess
Jstar = J./J0; % scale Jacobian
if any(isnan(Jstar(:))) || any(isinf(Jstar(:)))
    exitflag = -1; % matrix may be singular
else
    exitflag = 1; % normal exit
end


resnorm = norm(F); % calculate norm of the residuals
dx = zeros(size(x0)); 
%% solver
Niter = 0; % start counter
lambda = 1; % backtracking

while (resnorm>TOLFUN || lambda<1) && exitflag>=0 && Niter<=MAXITER
    if lambda==1
        %% Newton-Raphson solver
        Niter = Niter+1; % increment counter
        dx_star = -Jstar\F; % calculate Newton step
        % NOTE: use isnan(f) || isinf(f) instead of STPMAX
        dx = dx_star.*TYPX; % rescale x
        g = F'*Jstar; % gradient of resnorm
        slope = g*dx_star; % slope of gradient
        fold = F'*F; % objective function
        xold = x; % initial value
        lambda_min = TOLX/max(abs(dx)./max(abs(xold), 1));
    end
    if lambda<lambda_min
        exitflag = 2; % x is too close to XOLD
        break
    elseif any(isnan(dx)) || any(isinf(dx))
        exitflag = -1; % matrix may be singular
        break
    end
    x = xold+dx*lambda; % next guess
    [F, J] = FUN(x); % evaluate next residuals
    Jstar = J./J0; % scale next Jacobian
    f = F'*F; % new objective function
    %% check for convergence
    lambda1 = lambda; % save previous lambda
    if f>fold+ALPHA*lambda*slope
        if lambda==1
            lambda = -slope/2/(f-fold-slope); % calculate lambda
        else
            A = 1/(lambda1 - lambda2);
            B = [1/lambda1^2,-1/lambda2^2;-lambda2/lambda1^2,lambda1/lambda2^2];
            C = [f-fold-lambda1*slope;f2-fold-lambda2*slope];
            coeff = num2cell(A*B*C);
            [a,b] = coeff{:};
            if a==0
                lambda = -slope/2/b;
            else
                discriminant = b^2 - 3*a*slope;
                if discriminant<0
                    lambda = MAX_LAMBDA*lambda1;
                elseif b<=0
                    lambda = (-b+sqrt(discriminant))/3/a;
                else
                    lambda = -slope/(b+sqrt(discriminant));
                end
            end
            lambda = min(lambda,MAX_LAMBDA*lambda1); % minimum step length
        end
    elseif isnan(f) || isinf(f)
        % limit undefined evaluation or overflow
        lambda = MAX_LAMBDA*lambda1;
    else
        lambda = 1; % fraction of Newton step
    end
    if lambda<1
        lambda2 = lambda1;f2 = f; % save 2nd most previous value
        lambda = max(lambda,MIN_LAMBDA*lambda1); % minimum step length
        continue
    end
    %% display
    resnorm = norm(F); % calculate new resnorm

    
    if any(isnan(Jstar(:))) || any(isinf(Jstar(:)))
        exitflag = -1; % matrix may be singular
        break
    end
    

    
end
%% output
output.iterations = Niter; % final number of iterations
output.stepsize = dx; % final stepsize
output.lambda = lambda; % final lambda
if Niter>=MAXITER
    exitflag = 0;
    output.message = 'Number of iterations exceeded OPTIONS.MAXITER.';
elseif exitflag==2
    output.message = 'May have converged, but X is too close to XOLD.';
elseif exitflag==-1
    output.message = 'Matrix may be singular. Step was NaN or Inf.';
else
    output.message = 'Normal exit.';
end

end

function [F, J] = funwrapper(fun, x)
% if nargout<2 use finite differences to estimate J
try
    [F, J] = fun(x);
catch
    F = fun(x);
    J = jacobian(fun, x); % evaluate center diff if no Jacobian
end
F = F(:); % needs to be a column vector
end

function J = jacobian(fun, x)
% estimate J
dx = eps^(1/3); % finite difference delta
nx = numel(x); % degrees of freedom
nf = numel(fun(x)); % number of functions
J = zeros(nf,nx); % matrix of zeros
for n = 1:nx
    % create a vector of deltas, change delta_n by dx
    delta = zeros(nx, 1); delta(n) = delta(n)+dx;
    dF = fun(x+delta)-fun(x-delta); % delta F
    J(:, n) = dF(:)/dx/2; % derivatives dF/d_n
end
end