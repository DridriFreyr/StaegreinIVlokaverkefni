%% H�r s�st li�urinn �r fallinu Galerkinadferd sem b�tir punktuppspretum vi� h�gri hli�.
% Stingum svo inn punktuppsprettum ef ��r eru til sta�ar, en ef engar uppsprettur eru kalla�ar me� fallinu, sleppir forriti� �essum li�.
if ~isempty(r)
m=length(r);
for j=1:m
    i=max(find(x<=r(j)));
    b(i)= b(i)+Q(j);
end
end