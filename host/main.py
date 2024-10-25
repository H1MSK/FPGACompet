from web_client import *
import numpy as np
import cv2

def main():
  print("start")
  connect()
  print("connected")
  for case in range(2):
    print(f"Case #{case}:")
    img_in: np.ndarray = cv2.imread("./test_in.png", cv2.IMREAD_GRAYSCALE)
    print(f"image read from disk, shape: {img_in.shape}")
    write_img(img_in.flatten().tolist())
    print("image sent to FPGA")
    write_arg(0x00, 0x01)
    print("starting computation")
    while read_arg(0x01) != 0x01:
      pass
    print("computation finished")
    img_out: List[int] = read_img()
    print("image received from FPGA")
    img_out = np.array(img_out).reshape(img_in.shape)
    print(f"image shape: {img_out.shape}")
    cv2.imwrite("./test_out.png", img_out)
    print("image written to disk")

if __name__ == "__main__":
  main()
