proc iml;
seed = 1;
N = 1000;
beta = {0.5, 0.5};
income = randfun(N, "Normal", 0, 1);
X = j(N, 1, 1);
X = X || income;
j = ncol(X);
var1 = j(N,j);
call randgen(var1, "Uniform");
epsilon = -log(-log(var1));
betaaugmented = beta || 0*beta;
utility = X*betaaugmented + epsilon;

*/ now time to do for loop to generate actual choices */;

Y = j(n, 1, 0);

do i = 1 to n;
a = utility[i, 1];
b = utility[i, 2];
if a > b then do;
Y[i] = 1;
end;
end;

*/ next code to write is the log likelihood function */;
*/ before function starts try to see if you can get the equations right */;

start LOGL(beta) global(X, Y);
beta = beta`;
xbeta = X*beta;
lambdaxb = exp(xbeta)/(1 + exp(xbeta));
temp1 = Y#log(lambdaxb);
temp2 = (1 - Y)#log(lambdaxb);
ll_i = temp1 + temp2;
LL = -sum(ll_i);
return(LL);
finish LOGL;

x0 = {0.5 0.5};
opt = {1, 4};

beta1 = {0.5 0.5};
var1 = LOGL(beta1);

beta2 = {0 0};
var2 = LOGL(beta2);

print var1 var2;

call nlptr(xr, rc, "LOGL", x0, opt);
