function [ bit_single ] = halfBin2SingleBin( bit_half )
%HALFBIN2SINGLEBIN Summary of this function goes here
%   inja faghat extend mikone bit e mantisa ro, exponent o adjust mikone o
%   0 ro tashkhis mide. vas eadadaye kichik beja 0.f hanooz hamun 1.f ro
%   dar nazar migirim. pas momkene 1.0e-15 ta khata bede vaghti kheili
%   kuchik bashe adad

 
    
    %bit_a = dec2bin(typecast(single_no,'uint32'),32);
    
    sign_a      = bit_half(1);         %1  Sign (0 = positive, 1 = negative)
    expo_a      = bit_half(2:6);       %8  Exponent, biased by 127
    mant_a      = bit_half(7:16);     %23 Fraction f of the number 1.f
    
    
    new_expo = (bin2dec(expo_a) -15) + 127;
    
    if ( bin2dec(expo_a) == 0)
        new_expo =0;
        disp('precision scale has happened!');
    end
    
    expo_a      = dec2bin(new_expo,8);
    mant_a      = horzcat(mant_a,'0000000000000');
    
    bit_single = horzcat (sign_a,expo_a,mant_a);
end

