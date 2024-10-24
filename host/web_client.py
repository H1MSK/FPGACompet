import socket
import struct
from typing import List
from constant import *

_sock: socket.socket = None

def connect(host, port):
  global _sock
  _sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
  _sock.connect((host, port))

def write_img(img: List[int]):
  # header has a 12 byte length
  buf = struct.pack('<iHHi', WRITE_IMG, 1024, 1024, 0) + bytes(img)
  _sock.send(buf)
  resp = _sock.recv(4)
  assert resp == b'ok\0\0'

def read_img():
  # header has a 12 byte length
  buf = struct.pack('<iHHi', READ_IMG, 1024, 1024, 0)
  _sock.send(buf)
  img = []
  for line in range(1024):
    resp = _sock.recv(1024)
    img.extend(struct.unpack('<B', resp[i * 4:(i + 1) * 4])[0] for i in range(1024))
  return img
  
def send_arg(addr: int, data: int):
  assert 0 <= addr < 1024
  # header has a 12 byte length
  buf = struct.pack('<iii', SEND_ARG, addr, data)
  _sock.send(buf)
  resp = _sock.recv(4)
  assert resp == b'ok\0\0'
  
def recv_arg(addr: int):
  assert 0 <= addr < 1024
  # header has a 12 byte length
  buf = struct.pack('<iii', RECV_ARG, addr, 0)
  _sock.send(buf)
  resp = _sock.recv(4)
  return struct.unpack('<I', resp)[0]
