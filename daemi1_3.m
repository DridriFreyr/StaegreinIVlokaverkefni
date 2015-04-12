% Keyrsluskr�in s�nir hvernig n�lgunargildi� breytist �egar vi� setjum punktuppsprettur � h�gri hli�ina.
X= [0:1/3:2];% Skilgreinum bili� sem vi� �tlum a� n�lga �:
% B�um til tv�r mismunandi n�lganir; me� og �n punktuppsprettu:
c=Galerkinadferd(@(x)x,@(x)(1./x),@(x)-2+0*x,X,[0,1],[-1,-2],[0,-2],0,0);
r=1;% L�tum punktuppsprettu me� st�r� 0.01 koma inn � punkti x=1
Q=0.01;
cc=Galerkinadferd(@(x)x,@(x)(1./x),@(x)-2+0*x,X,[0,1],[-1,-2],[0,-2],r,Q);
plot(X,c,'b') %Plottum upp n�lgun �n punktuppsprettu bl�a.
hold on
plot(X,cc,'g')%Plottum upp n�lgun me� punktuppsprettu gr�na.
