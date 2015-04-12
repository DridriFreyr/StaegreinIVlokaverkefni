%% Hér sést liðurinn úr fallinu Galerkinadferd sem bætir punktuppspretum við hægri hlið.
% Stingum svo inn punktuppsprettum ef þær eru til staðar, en ef engar uppsprettur eru kallaðar með fallinu, sleppir forritið þessum lið.
if ~isempty(r)
m=length(r);
for j=1:m
    i=max(find(x<=r(j)));
    b(i)= b(i)+Q(j);
end
end