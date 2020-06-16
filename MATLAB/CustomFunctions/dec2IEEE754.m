function [ bit_a,sign_a,expo_a,mant_a, machine_epsilon ] = dec2IEEE754( float_no, halfOrsingOrdbl )
%IEEE754 Summary of this function goes here
%   Detailed explanation goes here

if ( strcmp(halfOrsingOrdbl,'single'))
    single_no = single(float_nno); % make it 32 bits
    bit_a = dec2bin(typecast(single_no,'uint32'),32);
    
    sign_a      = bit_a(:,1);         %1  Sign (0 = positive, 1 = negative)
    expo_a      = bit_a(:,2:9);       %8  Exponent, biased by 127
    mant_a      = bit_a(:,10:32);     %23 Fraction f of the number 1.f
    
elseif ( strcmp(halfOrsingOrdbl,'half'))
    
    single_no = single(float_no); % make it 32 bits
    [sign_a, expo_a, mant_a] = singleTohalfBin( single_no );
    bit_a = horzcat(sign_a,expo_a,mant_a);
    
else
    double_no = double(float_no); % make it 64 bits
    bit_a = dec2bin(typecast(double_no,'uint64'),64);
    
    sign_a      = bit_a(:,1);         %1  Sign (0 = positive, 1 = negative)
    expo_a      = bit_a(:,2:12);      %11 Exponent, biased by 1023
    mant_a      = bit_a(:,13:64);     %52 Fraction f of the number 1.f
end

machine_epsilon = 2^ -(length(mant_a)+1);

end

