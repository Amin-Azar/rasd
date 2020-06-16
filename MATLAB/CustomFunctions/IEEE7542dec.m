function [ float_out ] = IEEE7542dec(bit_no)
%IEEE754 Summary of this function goes here
%   binary string e input migire, float mide. 

s2 = size(bit_no);
s2= s2(2);

if ( s2 == 32 )
    float_out = typecast(uint32(bin2dec2(bit_no)),'single');
    
elseif ( s2 ==  64 )
    float_out = typecast(uint64(bin2dec2(bit_no)),'double');
    
else
    float_out = NaN;
end

end
