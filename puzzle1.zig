const std = @import("std");

pub fn main() !void {
    const stdin = std.io.getStdIn().reader();
    const stdout = std.io.getStdOut().writer();
    var buf: [8]u8 = undefined;

    var increases: i64 = 0;
    var prev: i64 = blk: {
        if (try stdin.readUntilDelimiterOrEof(buf[0..], '\n')) |input| {
            break :blk try std.fmt.parseInt(i64, input, 10);
        }
        unreachable;
    };


    while (try stdin.readUntilDelimiterOrEof(buf[0..], '\n')) |input| {
        const number = try std.fmt.parseInt(i64, input, 10);
        if (number > prev) increases += 1;
        prev = number;
    }

    try stdout.print("{}\n", .{increases});
}
