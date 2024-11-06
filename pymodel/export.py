import struct
import lightning as L
import torch
import cv2
import numpy as np

from dataset import BipedDataset
from lit_model import LitModel
from lit_modelv2 import LitModel as LitModelV2
from config import *

def export(out_file = "model.bin"):
  fp = open(out_file, "wb")

  model = LitModel.load_from_checkpoint(CHECKPOINT, hidden_channels=32).to("cpu")

  model.eval()
  
  fp.write(struct.pack("<I", 1))  # byte #0~3: 1 resblock

  params = model.model.conv1.parameters()
  for i, param in enumerate(params):
    assert i == 0
    export_param(fp, param)
  
  params = model.model.conv2.parameters()
  for i, param in enumerate(params):
    assert i == 0
    export_param(fp, param)
  
  fp.close()

def export_param(fp, param):
    p_oc, p_ic, p_h, p_w = param.shape
    # byte 4+i*Group+0~1: p_oc
    # byte 4+i*Group+2~3: p_ic
    fp.write(struct.pack("<HH", p_oc, p_ic))
    for oc in range(p_oc):
      for ic in range(p_ic):
        if oc < p_oc and ic < p_ic:
          dat = param[oc, ic].detach().numpy()
        else:
          dat = np.zeros(param[0, 0].shape)
        for h in range(p_h):
          for w in range(p_w):
            fp.write(struct.pack("<f", dat[h, w]))
        print(f"{oc},{ic}: {dat}")

def exportv2():
  model = LitModelV2.load_from_checkpoint(CHECKPOINT, hidden_channels=32)
  pass

if __name__ == "__main__":
  export()
