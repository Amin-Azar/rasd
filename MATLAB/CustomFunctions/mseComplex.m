function [ res_mse ] = mseComplex( Accur_cmplx, Apprx_cmplx )
%MSECOMPLEX Summary of this function goes here
%   e.g. => mseComplex(BOXtoMEM_orig,BOXtoMEM_appx)

res_mse = mean((abs(Accur_cmplx-Apprx_cmplx).^2).' ).';

end

