from typing import Literal
from torchvision.datasets.mnist import MNIST
from torchvision.transforms import ToTensor
import torch

class MyDataSet(torch.utils.data.Dataset):
    def __init__(self, mode: Literal["train"] | Literal["val"]) -> None:
        super().__init__()
        self.dataset = MNIST(
            root="./data",
            train= mode == "train",
            download=True,
            transform=ToTensor(),
        )
        # seg = round(len(self.dataset) * 0.9)
        # if mode == "train":
        #     self.dataset = self.dataset[:seg]
        # elif mode == "val":
        #     self.dataset = self.dataset[seg:]
        # else:
        #     raise ValueError("mode must be train or val")

    def __getitem__(self, index):
        img, label = self.dataset[index]
        return img, img
    
    def __len__(self) -> int:
        return len(self.dataset)