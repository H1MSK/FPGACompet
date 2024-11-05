import lightning as L
import torch
from torch import nn
from torch import functional as F
from lightning.pytorch.callbacks import ModelCheckpoint

from dataset import MyDataSet
from model import Model
from lane_dataset import LaneDataSet

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
    tensorboard = self.logger.experiment
    tensorboard.add_image("input", x[0], self.global_step)
    tensorboard.add_image("prediction", pred[0], self.global_step)
    tensorboard.add_image("ground_truth", y[0], self.global_step)
    
  def configure_optimizers(self):
    self.opt = torch.optim.Adam(self.parameters(), lr=1e-3)
    self.sched = torch.optim.lr_scheduler.ReduceLROnPlateau(self.opt, patience=5)
    return {"optimizer": self.opt, "lr_scheduler": self.sched, "monitor": "train_loss"}
  
train_model = LitModel(32)
data_loader = torch.utils.data.DataLoader(LaneDataSet(train=True), batch_size=32)
val_data_loader = torch.utils.data.DataLoader(LaneDataSet(train=False), batch_size=32)

trainer = L.Trainer(
  max_epochs=10,
  default_root_dir="./train",
  callbacks=[
    ModelCheckpoint(save_last=True, every_n_epochs=1)
  ]
  )
trainer.fit(train_model, data_loader, val_data_loader)
