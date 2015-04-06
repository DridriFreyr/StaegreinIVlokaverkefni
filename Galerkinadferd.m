function c=galerkinadferd_2(p,q,f,x,alpha,beta,gamma,r,Q)

N=length(x);
h=x(2:N)-x(1:N-1);
m=(x(2:N)+x(1:N-1))/2;
pm=p(m);
qm=q(m);
fx=f(x);

A=zeros(N,3);
b=zeros(N,1);

A(2:N-1,2) = pm(1:N-2)./h(1:N-2)+pm(2:N-1)./h(2:N-1)+(h(1:N-2).*qm(1:N-2)+h(2:N-1).*qm(2:N-1))/3;
A(2:N,1) = -pm(1:N-1)./h(1:N-1)+h(1:N-1).*qm(1:N-1)/6;
A(1:N-1,3) = A(2:N,1);
b(2:N-1) = (h(1:N-2).*(fx(1:N-2)+2*fx(2:N-1))+h(2:N-1).*(2*fx(2:N-1)+fx(3:N)))/6;

if beta(1) == 0
    A(1,2) = alpha(1);
    A(1,3) = 0;
    b(1) = gamma(1);
else
    A(1,2) = pm(1)/h(1)+h(1)*qm(1)/3+p(x(1))*alpha(1)/beta(1);
    b(1) = h(1)*(2*fx(1)+fx(2))/6+p(x(1))*gamma(1)/beta(1);
end

if beta(2) == 0
    A(N,1) = 0;
    A(N,2) = alpha(2);
    b(n) = gamma(2);
else
    A(N,2) = pm(N-1)/h(N-1)+h(N-1)*(qm(N-1)/3)+(p(x(N))*(alpha(2)/beta(2)));
    b(N) = h(N-1)*(fx(N-1)+2*fx(N))/6+p(x(N))*(gamma(2)/beta(2));
end

if ~isempty(r)
m=length(r);
for j=1:m
    i=max(find(x<=r(j)));
    b(i-1)=b(i-1)+Q(j)*(1-(r(j)-x(i-1))/(x(i)-x(i-1)));
    b(i) = b(i)+Q(j)*(r(j)-x(i-1))/(x(i)-x(i-1));
end
end

c=tridiagonal_solve(A,b);