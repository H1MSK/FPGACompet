import struct
import torch
from torch import nn

from export import exportConv, exportTensor3d

def testOrder():
    a = nn.Conv2d(3, 3, 3, padding=1)
    print(a.weight)
    with open("conv.bin", "wb") as fp:
        exportConv(fp, a)
    i = torch.rand(3, 6, 6)
    with open("input.bin", "wb") as fp:
        exportTensor3d(i, fp)
    o = a(i)
    with open("output.bin", "wb") as fp:
        exportTensor3d(o, fp)
    print(i, o)

if __name__ == '__main__':
    testOrder()
