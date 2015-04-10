h1 = 5;
h2 = 50;
e = 0.2;
sigma = (5.669*10^-8);
T0 = 298;
T1 = 298;
lambda1 = 0.1;
lambda2 = 140;
gamma1 = h1*T0;
a = 0;
s = 0.008;
r = 0.01;
b = 0.016;
x =[0, 0.0008, 0.01, 0.016];
q = @(x) x.*0;
p = @(x) lambda1 + (lambda2 - lambda1)*(x >= r); %Heaviside
f = @(x) x.*0;
beta = [0.1,140]; %lambda1,lambda2
Q = 235/0.024;
Q0 = Q/0.024;
v=[473];
skekkja = 1;

while skekkja>0.01
    %itra galerkin til að haekka hk
    hk=h2+e*sigma*(v(end) +T1)*(v(end)^2+T1^2);
    gamma=[h1*T0,hk*T1];
    alpha=[h1,hk];
    v1=v(end);
    v = Galerkinadferd( p,q,f,x,alpha,beta,gamma,r,Q );
    skekkja=abs(v1-v(end))/v1;
end
disp(v(end))
plot(x,(v-273))