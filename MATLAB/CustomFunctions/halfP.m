function [ half_no_inSingleFormat ] = halfp( float_no )
%HALFPRECISION Summary of this function goes here
%   double or single to single and then to half precision
% supports complex numbers yet

isComplex = whos('float_no');
isComplex = isComplex.complex;

if ( isComplex)
    
    half_no_inSingleFormat_rl = IEEE7542dec( dec2IEEE754( real(float_no),'half'));
    half_no_inSingleFormat_im = IEEE7542dec( dec2IEEE754( imag(float_no),'half'));
    
    half_no_inSingleFormat = complex (half_no_inSingleFormat_rl,half_no_inSingleFormat_im);
    
else
    half_no_inSingleFormat = IEEE7542dec( dec2IEEE754(float_no,'half'));
end

end

