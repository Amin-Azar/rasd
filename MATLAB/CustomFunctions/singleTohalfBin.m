function [ sign_a,expo_a,mant_a ] = singleTohalfBin( float_no )
%HALFPRECISION  
%   double or single -> single -> half precision


single_no = single(float_no); % make it 32 bits

bit_a = dec2bin(typecast(single_no,'uint32'),32);

sign_a      = bit_a(:,1);         %1  Sign (0 = positive, 1 = negative)
expo_a      = bit_a(:,2:9);       %8  Exponent, biased by 127
mant_a      = bit_a(:,10:32);     %23 Fraction f of the number 1.f

new_expo = (bin2dec(expo_a) -127) + 15;

%agar dadeyi vojud dasht ke daghetash o ma nadashtim
if(sum(new_expo < 0) > 0) % < 2^-15
    new_expo (new_expo <0)= 0;
    expo_a      = dec2bin ( new_expo,5 );
    mant_a      = dec2bin(bin2dec2(mant_a(:,1:10))+ bin2dec2(mant_a(:,11:11)),10);
    disp('precision scale has happened!');
% agar dadeyi vojud dasht ke ja nemishod
elseif (sum(new_expo > 31)>0) % > 2^16
    disp('range exceed!!');
    sign_a = NaN;
    expo_a = NaN;
    mant_a = NaN;
else
    expo_a      = dec2bin ( new_expo,5 );
    mant_a      = dec2bin(bin2dec2(mant_a(:,1:10))+ bin2dec2(mant_a(:,11:11)),10);% bite 11om o nega mikonim, age 1 bud yeki add mikonim be 10 ta bit e avval
end

    %bit_a =  horzcat(sign_a,expo_a,mant_a);

end

