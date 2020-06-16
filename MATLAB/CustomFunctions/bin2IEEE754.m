function [ bit_a,sign_a,expo_a,mant_a, machine_epsilon ] = bin2IEEE754( bin, halfOrsingOrdbl )
%IEEE754 Summary of this function goes here
%   Detailed explanation goes here

if ( strcmp(halfOrsingOrdbl,'single'))
    bit_a = bin;
    
    sign_a      = bit_a(:,1);         %1  Sign (0 = positive, 1 = negative)
    expo_a      = bit_a(:,2:9);       %8  Exponent, biased by 127
    mant_a      = bit_a(:,10:32);     %23 Fraction f of the number 1.f
    
elseif ( strcmp(halfOrsingOrdbl,'half'))
    
        bit_a = bin;
    
else
    bit_a = bin;
    
    sign_a      = bit_a(:,1);         %1  Sign (0 = positive, 1 = negative)
    expo_a      = bit_a(:,2:12);      %11 Exponent, biased by 1023
    mant_a      = bit_a(:,13:64);     %52 Fraction f of the number 1.f
end

machine_epsilon = 2^ -(length(mant_a)+1);

end