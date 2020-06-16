function [ bit_no_out ] = maskBits( bit_no, cnt )
%MASKBITS Summary of this function goes here
%   gets string bit array return masked.

s2 = size(bit_no);
s2 = s2(2);

if ( s2< cnt);
    cnt = s2;
end
num_repres = bit_no -48;
num_repres (:,end-cnt+1:end) = 0; %make them zeros;
bit_no_out = char(num_repres+48);

end

