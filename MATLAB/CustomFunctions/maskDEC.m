function [ OUT_dec_vec ] = maskDEC( IN_dec_vec ,n)
%MASKDEC Summary of this function goes here
%   n= number of bits is going to be masked from Real & Imagginary parts
% Column wise output

% double 64 bit, az akhar mask mikone
%single 32bit az akhar mask mikone
% half single reperesent shode, extend shode (tavan 3 bit, ashar 13 bit)  pas 13 bit e akharesh asan sare karie.
% behtare ba half kar nakonim asn filan

if ( n <1)
    OUT_dec_vec = IN_dec_vec;
else
    
in_type = whos('IN_dec_vec');
in_type = in_type.class; % single OR double

RL_fft = real(IN_dec_vec);
IM_fft = imag(IN_dec_vec);

RL_fft_ieee = dec2IEEE754(RL_fft, in_type);
IM_fft_ieee = dec2IEEE754(IM_fft, in_type);

RL_fft_ieee_new = maskBits(RL_fft_ieee, n);
IM_fft_ieee_new = maskBits(IM_fft_ieee, n);

RL_fft_new = IEEE7542dec(RL_fft_ieee_new);
IM_fft_new = IEEE7542dec(IM_fft_ieee_new);

OUT_dec_vec = complex (RL_fft_new, IM_fft_new);

end

s1 = size(OUT_dec_vec);
% make it Row-wise
if (s1(2) <  s1(1))
    OUT_dec_vec = OUT_dec_vec.';
end



end

