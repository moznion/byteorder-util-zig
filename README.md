# byteorder-util

An utility library to convert the byte order between big-endian and little-endian for [Zig](https://ziglang.org/).

## Synopsis

```zig
const givenU16Bytes = [_]u8{ 0x01, 0x02 };
const givenU32Bytes = [_]u8{ 0x01, 0x02, 0x03, 0x04 };
const givenU64Bytes = [_]u8{ 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08 };

const leU16 = LittleEndian.toU16(givenU16Bytes); // => 513
const gotLeU16Bytes = LittleEndian.fromU16ToBytes(leU16); // == givenU16Bytes

const leU32 = LittleEndian.toU32(givenU32Bytes); // => 67305985
const gotLeU32Bytes = LittleEndian.fromU32ToBytes(leU32); // == givenU32Bytes

const leU64 = LittleEndian.toU64(givenU64Bytes); // => 578437695752307201
const gotLeU64Bytes = LittleEndian.fromU64ToBytes(leU64); // == givenU64Bytes

const beU16 = BigEndian.toU16(givenU16Bytes); // => 258
const gotBeU16Bytes = BigEndian.fromU16ToBytes(beU16); // == givenU16Bytes

const beU32 = BigEndian.toU32(givenU32Bytes); // => 16909060;
const gotBeU32Bytes = BigEndian.fromU32ToBytes(beU32); // == givenU32Bytes

const beU64 = BigEndian.toU64(givenU64Bytes); // => 72623859790382856;
const gotBeU64Bytes = BigEndian.fromU64ToBytes(beU64); // == givenU64Bytes
```

