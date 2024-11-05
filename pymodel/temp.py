from torchvision.datasets.mnist import MNIST
from torchvision.transforms import ToTensor
import torch

dataset = MNIST(
    root="./data",
    train=True,
    download=True,
    transform=[
        ToTensor(),
    ],
)


