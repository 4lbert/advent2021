const std = @import("std");

pub fn main() !void {
    const stdin = std.io.getStdIn().reader();
    const stdout = std.io.getStdOut().writer();
    const stderr = std.io.getStdErr().writer();
    var buf: [16]u8 = undefined;

    var x: i32 = 0;
    var depth: i32 = 0;

    while (try stdin.readUntilDelimiterOrEof(buf[0..], '\n')) |input| {
        if (std.mem.startsWith(u8, input, "forward ")) {
            const value = try std.fmt.parseInt(i32, input[8..], 10);
            x += value;
        } else if (std.mem.startsWith(u8, input, "down ")) {
            const value = try std.fmt.parseInt(i32, input[5..], 10);
            depth += value;
        } else if (std.mem.startsWith(u8, input, "up ")) {
            const value = try std.fmt.parseInt(i32, input[3..], 10);
            depth -= value;
        } else {
            try stderr.print("Failed to parse command", .{});
        }
    }

    const result = x * depth;
    try stdout.print("{}\n", .{ result });
}
