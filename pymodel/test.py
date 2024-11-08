import lightning as L
import torch
import cv2
import numpy as np

from dataset import BipedDataset
from lit_model import LitModel
from config import *


def test():

    model = LitModel.load_from_checkpoint(CHECKPOINT, hidden_channels=32)

    model.eval()

    dataset = BipedDataset("D:/DataSets/BIPED/", 720, 1080)
    train_dataset, val_dataset = torch.utils.data.random_split(dataset, [0.9, 0.1])

    img, gt = val_dataset[0]
    img_tensor = torch.tensor(img).to(model.device)

    with torch.no_grad():
        out = model(img_tensor)

    out = out.detach().cpu().numpy()

    cv2.imshow("img", img.transpose((1, 2, 0)))
    cv2.imshow("gt", gt.transpose((1, 2, 0)))
    cv2.imshow("out", out.transpose((1, 2, 0)))
    cv2.waitKey()


if __name__ == "__main__":
    test()
