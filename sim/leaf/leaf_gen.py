import sys
from pathlib import Path
from argparse import ArgumentParser, Namespace
import random
import math

def leaf(a,b,c,d):
    f = (a+b) - (c+d)
    return f
def toHex(x):
    if x >= 0:
        return x
    else:
        return 2**32+x

def parse_args():
    parser = ArgumentParser()
    parser.add_argument('--leaf_data', type=Path, default='leaf_data.txt', help='Filename of leaf data')
    parser.add_argument('--leaf_data_ans', type=Path, default='leaf_data_ans.txt', help='Filename of leaf data ans')
    parser.add_argument('--a', type=int, default='0', help='a')
    parser.add_argument('--b', type=int, default='6', help='b')
    parser.add_argument('--c', type=int, default='1', help='c')
    parser.add_argument('--d', type=int, default='5', help='d')
    parser.add_argument('--bits', type=int, default='0', help='Number of bits(1-64)')


    args = parser.parse_args()
    return args

if __name__ == '__main__':
    # Modify your test pattern here
    args = parse_args()
    
    a = args.a
    b = args.b
    c = args.c
    d = args.d
    print(str(args.a) + '_'+str(args.b) +'_'+str(args.c)+'_' + str(args.d))

    with open(args.leaf_data, 'w') as f_data:
        f_data.write('{:0>8x}\n'.format(toHex(a)))
        f_data.write('{:0>8x}\n'.format(toHex(b)))
        f_data.write('{:0>8x}\n'.format(toHex(c)))
        f_data.write('{:0>8x}\n'.format(toHex(d)))

    with open(args.leaf_data_ans, 'w') as f_ans:
        f_ans.write('{:0>8x}\n'.format(toHex(a)))
        f_ans.write('{:0>8x}\n'.format(toHex(b)))
        f_ans.write('{:0>8x}\n'.format(toHex(c)))
        f_ans.write('{:0>8x}\n'.format(toHex(d)))
        f_ans.write('{:0>8x}\n'.format(toHex(leaf(a,b,c,d))))
    
    if (args.bits != 0): 
        a = random.getrandbits(args.bits)
        b = random.getrandbits(args.bits)
        c = random.getrandbits(args.bits)
        d = random.getrandbits(args.bits)

        with open(args.leaf_data, 'w') as f_data:
            f_data.write('{:0>8x}\n'.format(toHex(a)))
            f_data.write('{:0>8x}\n'.format(toHex(b)))
            f_data.write('{:0>8x}\n'.format(toHex(c)))
            f_data.write('{:0>8x}\n'.format(toHex(d)))

        with open(args.leaf_data_ans, 'w') as f_ans:
            f_ans.write('{:0>8x}\n'.format(toHex(a)))
            f_ans.write('{:0>8x}\n'.format(toHex(b)))
            f_ans.write('{:0>8x}\n'.format(toHex(c)))
            f_ans.write('{:0>8x}\n'.format(toHex(d)))
            f_ans.write('{:0>8x}\n'.format(toHex(leaf(a,b,c,d))))

        
    
    