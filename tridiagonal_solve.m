% Stærðfræðigreining IVB
% Forrit til þess að leysa þríhornalínuhneppi.
% RS 8.3.2014.
%
% Gefið er n x 3 fylki A og n x 1 dálkvigur b
%
%  Fylkið A er gefið á forminu:
%
%  |0     d_1   u_1   |
%  |l_1   d_2   u_2   |
%  |l_2   d_3   u_3   |
%  | :     :     :    |
%  | :     :     :    |  
%  |l_n-2 d_n-1 u_n-1 |
%  |l_n-1 d_n     0   |
%
%  sem er pökkun á n x n þríhornalínufylkinu
%  
%  |d_1   u_1   0    ....... |
%  |l_1   d_2  u_2   0  .... |
%  | 0    l_2  d_3  u_3  ... |
%  | :     0   l_3  d_3  ... |
%  | :     :    :     :  ... |
%
% Jöfnuhneppið Ac=b er leyst með LU-þáttun, 
% sem skrifuð er ofan í fylkið A,
% og síðan er for- og endurinnsetningu beitt.
%
function c=tridiagonal_solve(A,b)
%
[n,m]=size(A);
%
% LU- þáttun með 1 á hornalínu L.
% Fylkið L er skrifað ofan í fyrsta dálk A
% Fylkið U er skrifað ofan í annan og þriðja
%
for i=2:n,
  A(i,1)=A(i,1)/A(i-1,2);
  A(i,2)=A(i,2)-A(i,1)*A(i-1,3);
end
%
% Forinnsetning
%
for i=2:n,
  b(i)=b(i)-A(i,1)*b(i-1);
end
%
% Endurinnsetning
%
b(n)=b(n)/A(n,2);
for i=n-1:-1:1,
  b(i)=(b(i)-A(i,3)*b(i+1))/A(i,2);
end
c=b;
