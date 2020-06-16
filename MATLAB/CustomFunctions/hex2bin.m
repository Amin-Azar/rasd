function bin = hex2bin(hex)
%reshape(dec2bin(hex'),[1,64])
    %transpose if needed
    s1 = size(hex);
    if(s1(1) < s1(2))
        hex = hex';
    end
        
    %fill proceeding emty chars (= '000FF123'<='   F123')
    hex(hex==' ')='0';
    hex = hex -48;
    hex ( hex > 16) = hex (hex > 16) -7;
    n = numsamples(hex); % 16 hex characters
    n = n *4; % 64 bit
    bin( numelements(hex),n) = char(0);
    for i= 1: numelements(hex)
        bin(i,:) = reshape(dec2bin(hex(i,:),4)',[1,n]);
    end
end
