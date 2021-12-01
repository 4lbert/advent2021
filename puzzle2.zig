const std = @import("std");

pub fn main() !void {
    const stdin = std.io.getStdIn().reader();
    const stdout = std.io.getStdOut().writer();
    const stderr = std.io.getStdErr().writer();
    var buf: [8]u8 = undefined;

    var window = [3]i32{ 0, 0, 0 };
    var latest: u8 = 2;

    for (window) |_, i| {
        if (try stdin.readUntilDelimiterOrEof(buf[0..], '\n')) |input| {
            const number = try std.fmt.parseInt(i32, input, 10);
            window[i] = number;
        } else {
            try stderr.print("Error: not enough values\n", .{});
            return;
        }
    }

    var increases: i32 = 0;
    var sum: i32 = 0;
    for (window) |value| {
        sum += value;
    }
    var prev = sum;

    while (try stdin.readUntilDelimiterOrEof(buf[0..], '\n')) |input| {
        const number = try std.fmt.parseInt(i32, input, 10);
        window[latest] = number;
        latest = (latest + 1) % 3;
        sum = 0;
        for (window) |value| {
            sum += value;
        }
        if (sum > prev) increases += 1;
        prev = sum;
    }

    try stdout.print("{}\n", .{increases});
}
