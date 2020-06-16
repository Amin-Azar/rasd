import struct
import binascii

def float_to_hex_string(_list):
    hex_string = ''.join(str(binascii.hexlify(struct.pack('>f', _l)).upper()).replace('b\'','').replace('\'','').replace('00','..') for _l in _list)
    return hex_string

def half_to_hex_string(_list):
    hex_string = ''.join(str(binascii.hexlify(struct.pack('>e', _l)).upper()).replace('b\'','').replace('\'','').replace('00','..') for _l in _list)
    return hex_string

def float_to_fixed_hex_string(_list, n_tot = 32, n_int = 8):
    hex_string = ''.join( float_to_fixed_hex_one(_l, n_tot, n_int).replace('00','..') for _l in _list)
    return hex_string 

def float_to_fixed_hex_one(_l, n_tot, n_int):

#    n_tot = 32
#    n_int = 16
    n_frc = n_tot-n_int

    n_shift = n_tot

    adj_int_part = int(_l)
    frc_part = _l-int(_l)
    adj_frc_part = int(frc_part*(2**n_shift))

    int_bin_string  = str((n_int*'0'  + bin( adj_int_part ).replace('0b', ''))[-n_int:]) #
    frac_bin_string = str(((n_shift*'0'+ bin( adj_frc_part ).replace('0b', ''))[-n_shift:])[:n_frc]) # 32 bits shift then cut to n_frac bits
    bin_string = int_bin_string + frac_bin_string
    hex_string = str( (n_tot*'0' + hex(int(bin_string,2)).upper().replace('0X',''))[-int(n_tot/4):])

    return hex_string

def float_hex_to_binary_string(_list):
    """
        ['34343434','67676767'] -> ['00110100001101000011010000110100', '01100111011001110110011101100111']
    """
    _binary_list=[]
    for _l in _list:
        _bin1 = bin(int(_l, 16))[2:]
        if len(_bin1) > 32:
            return None
        _bin1 = '0'*(32-len(_bin1)) + _bin1
        _binary_list.append(_bin1)
    return _binary_list


def binary_string_split_print(_list):
    # 1 8 23
    #['01111111100000000', '1000000001111111111111111111111'] -> ['0|11111111|00000000', '1|00000000|1111111111111111111111']
    _binary_list_print=[]
    for _l in _list:
        s = _l[0]
        e = _l[1:9]
        m = _l[9:]
        _binary_list_print.append('|'.join([s,e,m]))
    return _binary_list_print , int(e,2) # shifted back

def binary_string_split_print_denorm(_list): 
    #it will shift the  exponent left or right
    # 1 8 23
    #['01111111100000000', '1000000001111111111111111111111'] -> ['0|11111111|00000000', '1|00000000|1111111111111111111111']
    _binary_list_print=[]
    for _l in _list:
        #print(_l)
        s = _l[0]
        e = _l[1:9]
        m =  '.'*(255 - int(e,2)) + _l[9:] + '.'*int(e,2) 
        m = m[0:128]+'*'+ m[128:]
        m = m[100:-100] # filan 100 ta charactere az avalesh va az akahresh bardarim
        _binary_list_print.append('|'.join([s,e,m]))
    return _binary_list_print , int(e,2) # shifted back

#print(binary_string_split_print(['01111111100000000', '1000000001111111111111111111111']))