import struct
import lightning as L
import torch
import cv2
import numpy as np

from torch import nn
from lit_model import LitModel
from lit_modelv2 import LitModel as LitModelV2
from config import *

def exportConv(fp, conv: nn.Conv2d):
  weight = conv.weight
  p_oc, p_ic, p_h, p_w = weight.shape
  # byte 4+i*Group+0~1: p_oc
  # byte 4+i*Group+2~3: p_ic
  fp.write(struct.pack("<HH", p_oc, p_ic))
  for oc in range(p_oc):
    for ic in range(p_ic):
      dat = weight[oc, ic].detach().cpu().numpy()
      for h in range(p_h):
        for w in range(p_w):
          fp.write(struct.pack("<f", dat[h, w]))

def exportTensor3d(tensor, fp):
  ic, h, w = tensor.shape
  i_np = tensor.detach().cpu().numpy()
  fp.write(struct.pack("<HHHH", 1, ic, h, w))
  for ch in range(ic):
    for row in range(h):
      for col in range(w):
        fp.write(struct.pack("<f", i_np[ch, row, col]))

def export(out_file = "model.bin"):
  fp = open(out_file, "wb")

  model = LitModel.load_from_checkpoint(CHECKPOINT, hidden_channels=32).to("cpu")

  model.eval()

  fp.write(struct.pack("<I", 1))  # byte #0~3: 1 resblock

  exportConv(fp, model.model.conv1)
  exportConv(fp, model.model.conv2)

  fp.close()

def exportv2():
  model = LitModelV2.load_from_checkpoint(CHECKPOINT, hidden_channels=32)
  pass

if __name__ == "__main__":
  export()
