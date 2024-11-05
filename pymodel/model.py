from torch import nn

class Model(nn.Module):
  def __init__(self, hidden_channels: int):
    super(Model, self).__init__()
    self.conv1 = nn.Conv2d(3, hidden_channels, 3, 1, padding=1, bias=False)
    self.conv2 = nn.Conv2d(hidden_channels, 1, 3, 1, padding=1, bias=False)
    
  def forward(self, x):
    x = self.conv1(x)
    x = nn.functional.relu(x)
    x = self.conv2(x)
    return x
