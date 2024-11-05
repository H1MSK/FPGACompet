import random
import pandas as pd 
import os
import sys
import numpy as np
import time
import torch
import torch.nn as nn
import torch.nn.functional as F
from torch.utils.data import DataLoader
import torch.optim as optim
from torch.utils.tensorboard import SummaryWriter
from torch.utils.data import Dataset, DataLoader
import orjson as json
from torch.nn.modules.loss import _Loss
import matplotlib.pyplot as plt
import cv2
import tqdm
import argparse
from sklearn.cluster import DBSCAN
import json
import os

DEFAULT_SIZE = (512, 512)
# DATA_PATH = "/kaggle/input/tusimple/TUSimple/train_set"
DATA_PATH = os.path.dirname(os.path.abspath(__file__)) + "/../data/TUSimple"

class LaneDataSet(Dataset):
    def __init__(self, train=True, dataset_path=DATA_PATH, size=DEFAULT_SIZE):
        self._mode = "train" if train else "eval"
        self._dataset_path = dataset_path + "/train_set"
        self._image_size = size
        self._data = []
        self._process_labels()

    def __getitem__(self, idx):
        image_path = os.path.join(self._dataset_path, self._data[idx][0])
        image = cv2.imread(image_path)
        h, w, c = image.shape
        image = cv2.resize(image, self._image_size, interpolation=cv2.INTER_LINEAR)
        image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
        image = image[..., None]
        lanes = self._data[idx][1]

        segmentation_image = self._draw_lanes(h, w, lanes, "segmentation")
        # instance_image = self._draw_lanes(h, w, lanes, "instance")
        # instance_image = instance_image[..., None]

        image = torch.from_numpy(image).float().permute((2, 0, 1))
        segmentation_image = torch.from_numpy(segmentation_image.copy()).float()
        # instance_image = torch.from_numpy(instance_image.copy()).permute((2, 0, 1))
        # segmentation_image = segmentation_image.to(torch.int64)
        
        c, h, w = image.shape

        return image[:, h//2:, :] / 255., segmentation_image[np.newaxis, h//2:, :] #, instance_image

    def __len__(self):
        return len(self._data)

    def _draw_lanes(self, h, w, lanes, image_type):
        image = np.zeros((h, w), dtype=np.uint8)
        for i, lane in enumerate(lanes):
            color = 1 if image_type == "segmentation" else i + 1
            cv2.polylines(image, [lane], False, color, 10)

        image = cv2.resize(image, self._image_size, interpolation=cv2.INTER_NEAREST)
        return image

    def _process_labels(self):
        label_files = []
        if self._mode == "train":
            label_files = [os.path.join(self._dataset_path, f"label_data_{suffix}.json") for suffix in ("0313", "0531")]
        elif self._mode == "eval":
            label_files = [os.path.join(self._dataset_path, f"label_data_{suffix}.json") for suffix in ("0601",)]

        for label_file in label_files:
            with open(label_file) as f:
                for line in f:
                    info = json.loads(line)
                    image = info["raw_file"]
                    lanes = info["lanes"]
                    h_samples = info["h_samples"]
                    lanes_coords = []
                    for lane in lanes:
                        x = np.array([lane]).T
                        y = np.array([h_samples]).T
                        xy = np.hstack((x, y))
                        idx = np.where(xy[:, 0] > 0)
                        lane_coords = xy[idx]
                        lanes_coords.append(lane_coords)
                    self._data.append((image, lanes_coords))

if __name__ == '__main__':
  dataset = LaneDataSet(train=True)
  print(f"len = {len(dataset)}")
  idx = random.randint(0, len(dataset))
  x, y1 = dataset[idx]
  
  print(x.shape, y1.shape)

  x = x.numpy().reshape((DEFAULT_SIZE[1] // 2, DEFAULT_SIZE[0], 1))
  y1 = y1.numpy().reshape((DEFAULT_SIZE[1] // 2, DEFAULT_SIZE[0], 1))
  # y2 = y2.numpy().reshape((DEFAULT_SIZE[1], DEFAULT_SIZE[0], 1)) * 1.0
  pic = np.concatenate((x, y1), axis=1)
  cv2.imshow("pic", pic)
  
  cv2.waitKey()
