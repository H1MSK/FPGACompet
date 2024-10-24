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
  header = struct.pack('<IHHII', WRITE_IMG, 1024, 1024, 0, len(content))
  buf = header + content
  print(f"Write img, header: {header}")
  _sock.send(buf, )
  resp = _sock.recv(2)
  assert resp == b'ok'

def read_img():
  buf = struct.pack('<IHHiI', READ_IMG, 1024, 1024, 0, 0)
  print(f"Read img, header: {buf}")
  _sock.send(buf)
  resp = _sock.recv(2)
  assert resp == b'ok'
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
  buf = struct.pack('<IiiI', WRITE_ARG, addr, data, 0)
  print(f"Write arg, header: {buf}")
  _sock.send(buf)
  resp = _sock.recv(2)
  assert resp == b'ok'
  
def read_arg(addr: int):
  assert 0 <= addr < 1024
  buf = struct.pack('<IiiI', READ_ARG, addr, 0, 0)
  print(f"Read arg, header: {buf}")
  _sock.send(buf)
  resp = _sock.recv(2)
  assert resp == b'ok'
  resp = _sock.recv(4)
  return struct.unpack('<I', resp)[0]
