import numpy as np
import torch

from dataset import BipedDataset
from lit_model import LitModel
from constant import *
from export import exportIntTensor3d, exportModel, exportTensor3d


def testWithCModel():

    model = LitModel.load_from_checkpoint(CHECKPOINT, hidden_channels=32)

    model.eval()

    exportModel(model, "model.bin")

    dataset = BipedDataset("D:/DataSets/BIPED/", 720, 1080)

    img, gt = dataset[0]
    img_tensor = torch.tensor(img)
    exportTensor3d(img_tensor, "input.bin")

    exportTensor3d(torch.tensor(gt), "ground.bin")

    with torch.no_grad():
        out = model(img_tensor.to(model.device))

    out = out.detach().cpu().numpy()
    exportTensor3d(torch.tensor(out), "output.bin")

    quant_img = (img_tensor * 127).round().clone().detach().type(torch.int8)
    exportIntTensor3d(quant_img, "input_quant.bin")


if __name__ == "__main__":
    testWithCModel()
