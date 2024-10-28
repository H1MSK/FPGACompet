import math
from web_client import write_arg, read_arg

def gauss2d(sigma, x, y):
  return (1 / 2 * math.pi * sigma ** 2) * math.exp(-(x ** 2 + y ** 2) / (2 * sigma ** 2))

def gauss2d_kernel_coeff(size, sigma):
  assert size in (3, 5)
  coeff = [
      gauss2d(sigma, 0, 0),
      gauss2d(sigma, 0, 1),
      gauss2d(sigma, 1, 1)
    ]
  if size == 5:
    coeff.extend((
      gauss2d(sigma, 0, 2),
      gauss2d(sigma, 1, 2),
      gauss2d(sigma, 2, 2)
    ))
  else:
    coeff.extend((0, 0, 0))
  
  # 归一化
  total_coeff = sum(coeff)
  coeff = list(x / total_coeff for x in coeff)

  return coeff

def apply_gaussian_filter(sigma, size):
  # 计算卷积核
  coeff = gauss2d_kernel_coeff(size, sigma)
  
  # 量化
  coeff = (round(x * 256) for x in coeff)
  
  # 依次写入
  start_addr = 0x100
  addr_offset = 0x04
  
  cur_addr = start_addr
  for c in coeff:
    write_arg(cur_addr, c)
    check = read_arg(cur_addr)
    assert check == c
    cur_addr += addr_offset
    
  print(f"Gaussian filter({sigma}, {size}) applied, coeff = {coeff}")
    
def apply_threshold(low, high):
  low_addr = 0x080
  high_addr = 0x084
  write_arg(low_addr, low)
  check = read_arg(low_addr)
  assert check == low
  write_arg(high_addr, high)
  check = read_arg(high_addr)
  assert check == high
  print(f"Threshold({low}, {high}) applied")
