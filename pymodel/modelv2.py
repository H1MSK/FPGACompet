from torch import nn

class ResBlock(nn.Module):
  def __init__(self, in_channels: int, hidden_channels: int, out_channels: int):
    super(ResBlock, self).__init__()
    self.conv1 = nn.Conv2d(in_channels, hidden_channels, 3, 1, padding=1, bias=False)
    self.conv2 = nn.Conv2d(hidden_channels, out_channels, 3, 1, padding=1, bias=False)
    
  def forward(self, x):
    out = self.conv1(x)
    out = nn.functional.relu(out)
    out = self.conv2(out)
    return nn.functional.relu(x + out)
  
class ModelV2(nn.Module):
  def __init__(self, hidden_channels: int):
    super(ModelV2, self).__init__()
    self.res_block1 = ResBlock(3, hidden_channels, hidden_channels)
    self.res_block2 = ResBlock(hidden_channels, hidden_channels, hidden_channels)
    self.res_block3 = ResBlock(hidden_channels, hidden_channels, hidden_channels)
    self.res_block4 = ResBlock(hidden_channels, hidden_channels, 1)
    
  def forward(self, x):
    out = self.res_block1(x)
    out = self.res_block2(out)
    out = self.res_block3(out)
    out = self.res_block4(out)
    return out