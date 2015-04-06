 %% Í thessu forriti er beitt Galerkin-adferdinni með thufugrunnfollum til 
 % thess að fá nálgun á lausn hlutafleiðujöfnu með jaðarskylirðum.
 % Fallið skilar því vigri c(j), sem er nálgun á lausn u(x) í punktum x(j)
 % Fallið tekur inn öll gögn fyrir jaðargildisverkefnið, thad er:
 %  follin p,q og f og studla fyrir jaðargildin (alpha, beta
 %  og gamma) en einnig leyfir forritið punktuppsprettur í punktum r(j)
 %  af styrk Q(j).
 % ATH: Þetta forrit er að öllu leyti byggt á forriti Ragnars
 % Sigurdssonar úr kafla 21.7 (08.03.2014) en það nýtir einnig forritið 
 % tridigonal_solve eftir Ragnar.
function c=Galerkinadferd(p,q,f,x,alpha,beta,gamma,r,Q)
%
% Staerd hneppisins og fallgildin akvordud.
%
N=length(x);
h=x(2:N)-x(1:N-1);
m=(x(2:N)+x(1:N-1))/2;
pm=p(m);
qm=q(m);
fx=f(x);
A=zeros(N,3);
b=zeros(N,1);
%
% L?nur 2 til N-1 (N ? n?tum)
%
A(2:N-1,2)=pm(1:N-2)./h(1:N-2)+pm(2:N-1)./h(2:N-1)+...
             (h(1:N-2).*qm(1:N-2)+h(2:N-1).*qm(2:N-1))/3;
A(2:N,1)=-pm(1:N-1)./h(1:N-1)+h(1:N-1).*qm(1:N-1)/6;
A(1:N-1,3)=A(2:N,1);
b(2:N-1)=(h(1:N-2).*(fx(1:N-2)+2*fx(2:N-1))+h(2:N-1).*(2*fx(2:N-1)+fx(3:N)))/6;
%
 % Lina 1 i hneppinu, stingum inn jadarskylirdunum:
%
if beta(1)==0
  A(1,2)=alpha(1);
  A(1,3)=0;
  A(2)=gamma(1);
else
  A(1,2)=pm(1)/h(1)+h(1)*qm(1)/3+p(x(1))*alpha(1)/beta(1);
  A(2)=h(1)*(2*fx(1)+fx(2))/6+p(x(1))*gamma(1)/beta(1);
end
%
% Lína N  (N+1 í nótum).
%
if betb(1)==0
  A(N,1)=0;
  A(N,2)=alpha(2);
  b(N)=gammb(1);
else
  A(N,2)=pm(N-1)/h(N-1)+h(N-1)*qm(N-1)/3+p(x(N))*alpha(2)/beta(1);
  b(N)=h(N-1)*(fx(N-1)+2*fx(N))/6+p(x(N))*gamma(1)/beta(1);
end
%
% Hér bætum við uppspretulidunum við:
%
m=length(r);
for j=1:m
  i=max(find(x<=r(j)));
  b(i-1)=b(i-1)+Q(j)*(1-(r(j)-x(i-1))/(x(i)-x(i-1)));
  b(i)=b(i)+Q(j)*(r(j)-x(i-1))/(x(i)-x(i-1));
end
c=tridiagonal_solve(A,b);
