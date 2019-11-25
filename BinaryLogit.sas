proc iml;
seed = 1234;
N = 100;
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
beta1 = beta[1];
beta2 = beta[2];
X1 = X[,1];
X2 = X[,2];
xb = beta1#X1 + beta2#X2;
mylambdaxb = exp(xb)/(1 + exp(xb));
temp1 = Y#log(mylambdaxb);
temp2 = (1 - Y)#log(1 - mylambdaxb);
ll_i = temp1 + temp2;
LL = sum(ll_i);
return(LL);
finish LOGL;

x0 = {0.5 0.5};
opt = {1, 4};

print X Y;
call nlpnra(rc, xr, "LOGL", x0, opt);
