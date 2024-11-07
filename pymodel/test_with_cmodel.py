import torch

from dataset import BipedDataset
from lit_model import LitModel
from config import *
from export import exportModel, exportTensor3d

def testWithCModel():

  model = LitModel.load_from_checkpoint(CHECKPOINT, hidden_channels=32)

  model.eval()
  
  exportModel(model, "model.bin")

  dataset = BipedDataset("D:/DataSets/BIPED/", 720, 1080, 0)

  img, gt = dataset[0]
  img_tensor = torch.tensor(img).to(model.device)
  exportTensor3d(torch.tensor(img), "input.bin")
  exportTensor3d(torch.tensor(gt), "ground.bin")

  with torch.no_grad():
    out = model(img_tensor)

  out = out.detach().cpu().numpy()
  exportTensor3d(torch.tensor(out), "py_out.bin")



if __name__ == "__main__":
  testWithCModel()
