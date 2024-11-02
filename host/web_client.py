import socket
import struct
from typing import List
from constant import *

_sock: socket.socket = None

def connected():
  return _sock is not None

def connect(host = "169.254.128.192", port = 10240):
  global _sock
  _sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
  _sock.connect((host, port))
  
def disconnect():
  global _sock
  _sock.close()
  _sock = None

def write_img(img: List[int] | bytes):
  global _sock
  
  content = bytes(img)
  header = struct.pack('<IHHII', ID_WRITE_IMG, 1024, 1024, 0, len(content))
  buf = header + content
  
  print("Write img, sent")
  
  _sock.send(buf)
  resp = _sock.recv(8)
  
  print(f"recv")
  
  (c0, c1, _, content_len) = struct.unpack('<ccHI', resp)
  assert c0 == b'o' and c1 == b'k' and content_len == 0

def read_img():
  global _sock
  buf = struct.pack('<IHHiI', ID_READ_IMG, 1024, 1024, 0, 0)
  
  print(f"Read img, sent")
  
  _sock.send(buf)
  resp = _sock.recv(8)
  
  print(f"recv")
  
  (c0, c1, _, content_len) = struct.unpack('<ccHI', resp)
  assert c0 == b'o' and c1 == b'k' and content_len == 1024 * 1024 * 1
  
  img = []
  cur_len = 0
  total_len = 1024 * 1024 * 1
  while cur_len < total_len:
    resp = _sock.recv(min(MAX_PACK_SIZE, total_len - cur_len))
    cur_len += len(resp)
    img.extend(int(c) for c in resp)
  return img
  
def write_arg(addr: int, data: int):
  global _sock
  assert 0 <= addr < 1024
  buf = struct.pack('<IiiI', ID_WRITE_ARG, addr, data, 0)
  
  print(f"Write arg@{addr:x}:{data}, sent")
  
  _sock.send(buf)
  resp = _sock.recv(8)
  
  print(f"recv")
  
  (c0, c1, _, content_len) = struct.unpack('<ccHI', resp)
  assert c0 == b'o' and c1 == b'k' and content_len == 0

def read_arg(addr: int):
  global _sock
  assert 0 <= addr < 1024
  buf = struct.pack('<IiiI', ID_READ_ARG, addr, 0, 0)
  print(f"Read arg@{addr:x}, sent")# f" header: {buf}")
  _sock.send(buf)
  resp = _sock.recv(8)
  
  
  (c0, c1, _, content_len) = struct.unpack('<ccHI', resp)
  assert c0 == b'o' and c1 == b'k' and content_len == 4
  
  resp = _sock.recv(4)
  data = struct.unpack('<I', resp)[0]

  print(f"recv {data}")

  return data
