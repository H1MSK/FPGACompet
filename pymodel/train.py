import lightning as L
import torch
from torch import functional as F
from lightning.pytorch.callbacks import ModelCheckpoint

from dataset import BipedDataset
from lit_model import LitModel
from lit_modelv2 import LitModel as LitModelV2

def train(train_model: L.LightningModule, save_dir: str):
  dataset = BipedDataset("D:/DataSets/BIPED/", 720, 1080, 0)
  train_dataset, val_dataset = torch.utils.data.random_split(dataset, [0.9, 0.1])
  data_loader = torch.utils.data.DataLoader(train_dataset, batch_size=16)
  val_data_loader = torch.utils.data.DataLoader(val_dataset, batch_size=16)

  trainer = L.Trainer(
    max_epochs=-1,
    default_root_dir=save_dir,
    log_every_n_steps=2,
    callbacks=[
      ModelCheckpoint(save_last=True, every_n_epochs=1)
    ]
  )
  trainer.fit(train_model, data_loader, val_data_loader)

if __name__ == "__main__":
  train(LitModel(32), "./train/model_v1")
