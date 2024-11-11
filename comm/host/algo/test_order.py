import struct
import torch
from torch import nn

from export import exportConv, exportIntTensor3d, exportTensor3d


def testOrder():
    a = nn.Conv2d(1, 1, 3, padding=1, bias=False)
    print(a.weight)
    exportConv(a, "conv.bin")
    i = torch.rand(1, 2, 5)
    exportTensor3d(i, "input.bin")
    o = a(i)
    exportTensor3d(o, "output.bin")
    print(i)
    print(o)
    qi = (i * 127).round().clamp(-128, 127).to(torch.int8)
    exportIntTensor3d(qi, "input_quant.bin")
    print(qi)


if __name__ == "__main__":
    testOrder()
