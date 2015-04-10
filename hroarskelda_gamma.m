function z=hroarskelda_gamma(x,y)
%fremra op
if y >= 2
    z=max(0.8*cos(0.25*pi*x),0);
    %tjaldhliðar
elseif x >= 2 || x <= -2
    z=abs(exp(1/4*y)*0.1*sin(2/5*pi*y));
    %aftast
elseif y <= -0.5
    z= max(0.25*cos(0.25*pi*x),0);
else
    z=0;
end
end