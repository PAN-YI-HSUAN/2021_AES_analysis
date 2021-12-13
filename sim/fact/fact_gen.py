import sys
from pathlib import Path
from argparse import ArgumentParser, Namespace
import random
import math

def fact(n):
    if n < 1:
        return 1
    else:
        return n*fact(n-1)

def parse_args():
    parser = ArgumentParser()
    parser.add_argument('--fact_data', type=Path, default='fact_data.txt', help='Filename of fact data')
    parser.add_argument('--fact_data_ans', type=Path, default='fact_data_ans.txt', help='Filename of fact data ans')
    parser.add_argument('--n', type=int, default='3', help='n')

    args = parser.parse_args()
    return args

if __name__ == '__main__':
    # Modify your test pattern here
    args = parse_args()
    n = args.n
    print(args.n)
        
    with open(args.fact_data, 'w') as f_data:
        f_data.write('{:0>8x}\n'.format(n))

    with open(args.fact_data_ans, 'w') as f_ans:
        f_ans.write('{:0>8x}\n'.format(n))
        f_ans.write('{:0>8x}\n'.format(fact(n)))