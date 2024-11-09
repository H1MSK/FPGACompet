from model import Model


import lightning as L
import torch
from torch import nn
from torch.utils.tensorboard import SummaryWriter


class LitModel(L.LightningModule):
    def __init__(self, hidden_channels):
        super().__init__()
        self.model = Model(hidden_channels)
        self.loss_fn = nn.MSELoss()

    def forward(self, x):
        return self.model(x)

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
        return {
            "optimizer": self.opt,
            "lr_scheduler": self.sched,
            "monitor": "train_loss",
        }
