% Keyrsluskr�in s�nir hvernig n�lgunargildi� breytist �egar vi� setjum punktuppsprettur � h�gri hli�ina.

% Byrjum � a� skilgreina breyturnar:
p = @(x) x;
q = @(x) 1./x;
f = @(x) -2 + 0.*x;
u=@(x) x.*log(x)-x;
x = [0:1/3:2];
alpha=[0,1];
beta = [-1,-2];
gamma=[0,-2];
r=1;
Q=0.01;

% B�um til tv�r mismunandi n�lganir; me� og �n punktuppsprettu fyrir falli� u=x*ln(x)-x:
c=Galerkinadferd(p,q,f,x,alpha,beta,gamma,0,0);

cc=Galerkinadferd(p,q,f,x,alpha,beta,gamma,r,Q);
plot(x,c,'b') %Plottum upp n�lgun �n punktuppsprettu bl�a.
hold on
plot(x,cc,'g')%Plottum upp n�lgun me� punktuppsprettu gr�na.
