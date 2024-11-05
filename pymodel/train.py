import lightning as L
import torch
from torch import nn
from torch import functional as F
from lightning.pytorch.callbacks import ModelCheckpoint
from torch.utils.tensorboard import SummaryWriter

from dataset import BipedDataset
from model import Model

class LitModel(L.LightningModule):
  def __init__(self, hidden_channels):
    super().__init__()
    self.model = Model(hidden_channels)
    self.loss_fn = nn.MSELoss()
    
  def training_step(self, batch, batch_idx):
    x, y = batch
    pred = self.model(x)
    loss = self.loss_fn(pred, y)
    self.log("train_loss", loss)
    self.log("lr", self.opt.param_groups[0]["lr"])
    return loss
  
  def validation_step(self, batch, batch_idx):
    x, y = batch
    pred = self.model(x)
    loss = self.loss_fn(pred, y)
    self.log("val_loss", loss)
    tensorboard: SummaryWriter = self.logger.experiment
    tensorboard.add_image("input", x[0], self.global_step)
    tensorboard.add_image("prediction", pred[0], self.global_step)
    tensorboard.add_image("ground_truth", y[0], self.global_step)
    
  def configure_optimizers(self):
    self.opt = torch.optim.Adam(self.parameters(), lr=1e-3)
    self.sched = torch.optim.lr_scheduler.ReduceLROnPlateau(self.opt, patience=5)
    return {"optimizer": self.opt, "lr_scheduler": self.sched, "monitor": "train_loss"}
  
train_model = LitModel(32)
dataset = BipedDataset("D:/DataSets/BIPED/", 720, 1080, 0)
train_dataset, val_dataset = torch.utils.data.random_split(dataset, [0.9, 0.1])
data_loader = torch.utils.data.DataLoader(train_dataset, batch_size=16)
val_data_loader = torch.utils.data.DataLoader(val_dataset, batch_size=16)

trainer = L.Trainer(
  max_epochs=-1,
  default_root_dir="./train",
  log_every_n_steps=2,
  callbacks=[
    ModelCheckpoint(save_last=True, every_n_epochs=1)
  ]
)
trainer.fit(train_model, data_loader, val_data_loader)
