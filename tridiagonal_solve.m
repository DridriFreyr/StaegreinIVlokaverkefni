% St�r�fr��igreining IVB
% Forrit til �ess a� leysa �r�hornal�nuhneppi.
% RS 8.3.2014.
%
% Gefi� er n x 3 fylki A og n x 1 d�lkvigur b
%
%  Fylki� A er gefi� � forminu:
%
%  |0     d_1   u_1   |
%  |l_1   d_2   u_2   |
%  |l_2   d_3   u_3   |
%  | :     :     :    |
%  | :     :     :    |  
%  |l_n-2 d_n-1 u_n-1 |
%  |l_n-1 d_n     0   |
%
%  sem er p�kkun � n x n �r�hornal�nufylkinu
%  
%  |d_1   u_1   0    ....... |
%  |l_1   d_2  u_2   0  .... |
%  | 0    l_2  d_3  u_3  ... |
%  | :     0   l_3  d_3  ... |
%  | :     :    :     :  ... |
%
% J�fnuhneppi� Ac=b er leyst me� LU-��ttun, 
% sem skrifu� er ofan � fylki� A,
% og s��an er for- og endurinnsetningu beitt.
%
function c=tridiagonal_solve(A,b)
%
[n,m]=size(A);
%
% LU- ��ttun me� 1 � hornal�nu L.
% Fylki� L er skrifa� ofan � fyrsta d�lk A
% Fylki� U er skrifa� ofan � annan og �ri�ja
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
