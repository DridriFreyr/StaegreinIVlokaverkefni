a=0;
b=1;
c=-1;
d=1;
gamma = @(x,y) sqrt(cosh(x).^2-y.^2);
p = @(x,y) -1+0.*x+0.*y;
q = @(x,y) 0+0.*x+0.*y;
f = @(x,y) 0+0.*x+0.*y;
[W_dummy,A,RSH] = Dirichletverkefni(a,b,c,d,p,q,f,gamma,[],[],[],[],0.02);
W0 = Dirichletverkefni(a,b,c,d,p,q,f,gamma,[],[],[],[],0.02);
k=1;
eps=0.01;
kmax = 5;
error = 2*eps;
while(error > eps && k < kmax)
   W1=lagmarksflotur(a,b,c,d,p,q,f,gamma,[],[],[],[],0.02,W0');
   error = max(max(abs(W1-W0)));
   W0 = W1;
   k=k+1;
end