import struct


def loadFloatWeights(filename: str):
    with open(filename, "rb") as f:
        b = f.read()
        oc, ic = struct.unpack("<HH", b[:4])
        b = b[4:]
        dat = [struct.unpack("<f", b[i : i + 4])[0] for i in range(0, len(b), 4)]
        assert len(dat) == oc * ic * 9
        dat = [dat[i : i + ic] for i in range(0, len(dat), ic)]
        dat = [dat[i : i + oc] for i in range(0, len(dat), oc)]
    return dat

def loadQuantifiedWeights(filename: str):
    with open(filename, "rb") as f:
        b = f.read()
        oc, ic = struct.unpack("<HH", b[:4])
        b = b[4:]
        dat = [struct.unpack("<h", b[i : i + 2])[0] for i in range(0, len(b), 4)]
        assert len(dat) == oc * ic * 9
        dat = [dat[i : i + ic] for i in range(0, len(dat), ic)]
        dat = [dat[i : i + oc] for i in range(0, len(dat), oc)]
    return dat

if __name__ == "__main__":
    dat = loadFloatWeights("./weights/model.bin")
    print(dat)