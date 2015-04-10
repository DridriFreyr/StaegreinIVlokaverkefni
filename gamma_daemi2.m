function z = gamma_daemi2(x)
if x >= 0 && x <= 0.8e-2
    z = 1;
elseif x > 10e-2 && x <= 1.6e-2
    z = 2;
else
    z=0;
end