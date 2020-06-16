function [ hex ] = hexString2hex( oXhex , specifier )
%HEXSTRING2HEX Summary of this function goes here
%   0xFFFFFF ro migire, FFFFFF pas mide!

[elmnts,c] = size(oXhex);
hex = cell (elmnts,1);


if nargin < 2
    specifier = '0x';
end

    for i = 1:elmnts
    str = strsplit( oXhex(i,:), specifier);
    hex(i,:) = str(2);
    end

end

