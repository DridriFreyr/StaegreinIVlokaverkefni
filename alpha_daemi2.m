function z = alpha_daemi2(x)
if x >= 0 && x <= 0.8e-2
    z = 5;
elseif x > 10e-2 && x <= 1.6e-2
    z = 50;
else
    z=0;
end