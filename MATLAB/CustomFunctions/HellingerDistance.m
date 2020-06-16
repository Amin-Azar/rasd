function [ HD ] = HellingerDistance( rpmf_appx,rpmf_ref )
%HELLINGERDISTANCE Summary of this function goes here
%   gets 2 ranged-PMF and returns hellinger distance.

HD = sqrt(1-sum(sqrt(rpmf_appx .* rpmf_ref)));


end

