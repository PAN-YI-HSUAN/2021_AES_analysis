import sys
from pathlib import Path
from argparse import ArgumentParser, Namespace
import random
import math

def hw1(n):
    if n >= 2:
        y = 8*hw1(math.floor(n/2))+4*n
        return y
    else:
        return 7

def parse_args():
    parser = ArgumentParser()
    parser.add_argument('--hw1_data', type=Path, default='hw1_data.txt', help='Filename of hw1 data')
    parser.add_argument('--hw1_data_ans', type=Path, default='hw1_data_ans.txt', help='Filename of hw1 data ans')
    parser.add_argument('--n', type=int, default='7', help='n')

    args = parser.parse_args()
    return args

if __name__ == '__main__':
    # Modify your test pattern here
    args = parse_args()
    n = args.n
    print(args.n)
        
    with open(args.hw1_data, 'w') as f_data:
        f_data.write('{:0>8x}\n'.format(n))

    with open(args.hw1_data_ans, 'w') as f_ans:
        f_ans.write('{:0>8x}\n'.format(n))
        f_ans.write('{:0>8x}\n'.format(hw1(n)))
    
    # print('Generator data from n=1 to 10...')
    # for num in range(1, 11):
    #     print(num)

    #     dataFile = 'hw1_data'+str(num)+'.txt'
    #     ansdataFile = 'hw1_data_ans'+str(num)+'.txt'

    #     with open(dataFile, 'w') as f_data:
    #         f_data.write('{:0>8x}\n'.format(num))

    #     with open(ansdataFile, 'w') as f_ans:
    #         f_ans.write('{:0>8x}\n'.format(num))
    #         f_ans.write('{:0>8x}\n'.format(hw1(num)))