import struct
import torch
from torch import nn

from export import exportConv, exportTensor3d

def testOrder():
    a = nn.Conv2d(3, 3, 3, padding=1, bias=False)
    print(a.weight)
    exportConv(a, "conv.bin")
    i = torch.rand(3, 2, 5)
    exportTensor3d(i, "input.bin")
    o = a(i)
    exportTensor3d(o, "output.bin")
    print(i, o)

if __name__ == '__main__':
    testOrder()
