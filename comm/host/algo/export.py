import struct
from typing import Optional
import lightning as L
import torch
import cv2
import numpy as np

from torch import nn
from lit_model import LitModel
from lit_modelv2 import LitModel as LitModelV2
from constant import *


def exportConv(conv: nn.Conv2d, fp):
    if isinstance(fp, str):
        with open(fp, "wb") as the_fp:
            exportConv(conv, the_fp)
        return

    weight = conv.weight
    p_oc, p_ic, p_h, p_w = weight.shape
    # byte 4+i*Group+0~1: p_oc
    # byte 4+i*Group+2~3: p_ic
    fp.write(struct.pack("<IHH", ID_CONV_FLOAT, p_oc, p_ic))
    for oc in range(p_oc):
        for ic in range(p_ic):
            dat = weight[oc, ic].detach().cpu().numpy()
            for h in range(p_h):
                for w in range(p_w):
                    fp.write(struct.pack("<f", dat[h, w]))


def exportTensor3d(tensor, fp):
    if isinstance(fp, str):
        with open(fp, "wb") as the_fp:
            exportTensor3d(tensor, the_fp)
        return

    ic, h, w = tensor.shape
    i_np = tensor.detach().cpu().numpy()
    fp.write(struct.pack("<IHHHH", ID_FLOW_FLOAT, 1, ic, h, w))
    for ch in range(ic):
        for row in range(h):
            for col in range(w):
                fp.write(struct.pack("<f", i_np[ch, row, col]))


def exportIntTensor3d(tensor, fp):
    if isinstance(fp, str):
        with open(fp, "wb") as the_fp:
            exportIntTensor3d(tensor, the_fp)
        return

    ic, h, w = tensor.shape
    i_np = tensor.detach().cpu().numpy()
    fp.write(struct.pack("<IHHHH", ID_FLOW_QUANT, 1, ic, h, w))
    for ch in range(ic):
        for row in range(h):
            for col in range(w):
                fp.write(struct.pack("<b", i_np[ch, row, col]))


def exportModel(model: Optional[LitModel], fp="model.bin"):
    if isinstance(fp, str):
        with open(fp, "wb") as the_fp:
            exportModel(model, the_fp)
        return

    if model is None:
        model = LitModel.load_from_checkpoint(CHECKPOINT, hidden_channels=32).to("cpu")
        model.eval()

    fp.write(struct.pack("<II", ID_MODEL, 1))

    exportConv(model.model.conv1, fp)
    exportConv(model.model.conv2, fp)


def exportv2():
    raise NotImplementedError()
    model = LitModelV2.load_from_checkpoint(CHECKPOINT, hidden_channels=32)


if __name__ == "__main__":
    exportModel()
