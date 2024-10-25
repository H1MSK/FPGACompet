import socket
import struct
from typing import List
from constant import *

_sock: socket.socket = None

def connect(host = "localhost", port = 10240):
  global _sock
  _sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
  _sock.connect((host, port))

def write_img(img: List[int]):
  
  content = bytes(img)
  header = struct.pack('<IHHII', ID_WRITE_IMG, 1024, 1024, 0, len(content))
  buf = header + content
  
  print(f"Write img, sent header: {header}")
  
  _sock.send(buf)
  resp = _sock.recv(6)
  
  print(f"recv header: {resp}")
  
  (c0, c1, len) = struct.unpack('<ccI', resp)
  assert c0 == ord('o') and c1 == ord('k') and len == 0

def read_img():
  buf = struct.pack('<IHHiI', ID_READ_IMG, 1024, 1024, 0, 0)
  
  print(f"Read img, sent header: {buf}")
  
  _sock.send(buf)
  resp = _sock.recv(6)
  
  print(f"recv header: {resp}")
  
  (c0, c1, len) = struct.unpack('<ccI', resp)
  assert c0 == ord('o') and c1 == ord('k') and len == 1024 * 1024 * 1
  
  img = []
  cur_len = 0
  total_len = 1024 * 1024 * 1
  while cur_len < total_len:
    resp = _sock.recv(min(MAX_PACK_SIZE, total_len - cur_len))
    cur_len += len(resp)
    img.extend(int(c) for c in resp)
  return img
  
def write_arg(addr: int, data: int):
  assert 0 <= addr < 1024
  buf = struct.pack('<IiiI', ID_WRITE_ARG, addr, data, 0)
  
  print(f"Write arg, sent header: {buf}")
  
  _sock.send(buf)
  resp = _sock.recv(6)
  
  print(f"recv header: {resp}")
  
  (c0, c1, len) = struct.unpack('<ccI', resp)
  assert c0 == ord('o') and c1 == ord('k') and len == 0

def read_arg(addr: int):
  assert 0 <= addr < 1024
  buf = struct.pack('<IiiI', ID_READ_ARG, addr, 0, 0)
  print(f"Read arg, sent header: {buf}")
  _sock.send(buf)
  resp = _sock.recv(6)
  
  print(f"recv header: {resp}")
  
  (c0, c1, len) = struct.unpack('<ccI', resp)
  assert c0 == ord('o') and c1 == ord('k') and len == 4
  
  resp = _sock.recv(4)
  return struct.unpack('<I', resp)[0]
