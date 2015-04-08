function z=gamma_fall(x,y)
if abs(x) == 1
    z= 5.*max(cos(pi.*y));
elseif abs(y) == 1
    z= 5.*max(cos(pi.*x));
else
    z = 0;
end