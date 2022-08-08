const std = @import("std");
const mem = std.mem;
const testing = std.testing;

pub const LittleEndian = struct {
    pub fn toU16(b: [2]u8) u16 {
        return @as(u16, b[0]) | (@as(u16, b[1]) << 8);
    }

    pub fn fromU16ToBytes(v: u16) [2]u8 {
        return [2]u8{ @truncate(u8, v), @truncate(u8, v >> 8) };
    }

    pub fn toU32(b: [4]u8) u32 {
        return @as(u32, b[0]) | @as(u32, b[1]) << 8 | @as(u32, b[2]) << 16 | @as(u32, b[3]) << 24;
    }

    pub fn fromU32ToBytes(v: u32) [4]u8 {
        return [4]u8{ @truncate(u8, v), @truncate(u8, v >> 8), @truncate(u8, v >> 16), @truncate(u8, v >> 24) };
    }

    pub fn toU64(b: [8]u8) u64 {
        return @as(u64, b[0]) | @as(u64, b[1]) << 8 | @as(u64, b[2]) << 16 | @as(u64, b[3]) << 24 |
            @as(u64, b[4]) << 32 | @as(u64, b[5]) << 40 | @as(u64, b[6]) << 48 | @as(u64, b[7]) << 56;
    }

    pub fn fromU64ToBytes(v: u64) [8]u8 {
        return [8]u8{
            @truncate(u8, v),       @truncate(u8, v >> 8),  @truncate(u8, v >> 16), @truncate(u8, v >> 24),
            @truncate(u8, v >> 32), @truncate(u8, v >> 40), @truncate(u8, v >> 48), @truncate(u8, v >> 56),
        };
    }
};

pub const BigEndian = struct {
    pub fn toU16(b: [2]u8) u16 {
        return @as(u16, b[1]) | (@as(u16, b[0]) << 8);
    }

    pub fn fromU16ToBytes(v: u16) [2]u8 {
        return [2]u8{ @truncate(u8, v >> 8), @truncate(u8, v) };
    }

    pub fn toU32(b: [4]u8) u32 {
        return @as(u32, b[3]) | @as(u32, b[2]) << 8 | @as(u32, b[1]) << 16 | @as(u32, b[0]) << 24;
    }

    pub fn fromU32ToBytes(v: u32) [4]u8 {
        return [4]u8{ @truncate(u8, v >> 24), @truncate(u8, v >> 16), @truncate(u8, v >> 8), @truncate(u8, v) };
    }

    pub fn toU64(b: [8]u8) u64 {
        return @as(u64, b[7]) | @as(u64, b[6]) << 8 | @as(u64, b[5]) << 16 | @as(u64, b[4]) << 24 |
            @as(u64, b[3]) << 32 | @as(u64, b[2]) << 40 | @as(u64, b[1]) << 48 | @as(u64, b[0]) << 56;
    }

    pub fn fromU64ToBytes(v: u64) [8]u8 {
        return [8]u8{
            @truncate(u8, v >> 56), @truncate(u8, v >> 48), @truncate(u8, v >> 40), @truncate(u8, v >> 32),
            @truncate(u8, v >> 24), @truncate(u8, v >> 16), @truncate(u8, v >> 8),  @truncate(u8, v),
        };
    }
};

test "endian conversion" {
    const givenU16Bytes = [_]u8{ 0x01, 0x02 };
    const givenU32Bytes = [_]u8{ 0x01, 0x02, 0x03, 0x04 };
    const givenU64Bytes = [_]u8{ 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08 };

    try testing.expect(LittleEndian.toU16(givenU16Bytes) == 513);
    const gotLeU16Bytes = LittleEndian.fromU16ToBytes(513);
    try testing.expect(mem.eql(u8, &gotLeU16Bytes, &givenU16Bytes));

    try testing.expect(LittleEndian.toU32(givenU32Bytes) == 67305985);
    const gotLeU32Bytes = LittleEndian.fromU32ToBytes(67305985);
    try testing.expect(mem.eql(u8, &gotLeU32Bytes, &givenU32Bytes));

    try testing.expect(LittleEndian.toU64(givenU64Bytes) == 578437695752307201);
    const gotLeU64Bytes = LittleEndian.fromU64ToBytes(578437695752307201);
    try testing.expect(mem.eql(u8, &gotLeU64Bytes, &givenU64Bytes));

    try testing.expect(BigEndian.toU16(givenU16Bytes) == 258);
    const gotBeU16Bytes = BigEndian.fromU16ToBytes(258);
    try testing.expect(mem.eql(u8, &gotBeU16Bytes, &givenU16Bytes));

    try testing.expect(BigEndian.toU32(givenU32Bytes) == 16909060);
    const gotBeU32Bytes = BigEndian.fromU32ToBytes(16909060);
    try testing.expect(mem.eql(u8, &gotBeU32Bytes, &givenU32Bytes));

    try testing.expect(BigEndian.toU64(givenU64Bytes) == 72623859790382856);
    const gotBeU64Bytes = BigEndian.fromU64ToBytes(72623859790382856);
    try testing.expect(mem.eql(u8, &gotBeU64Bytes, &givenU64Bytes));
}
