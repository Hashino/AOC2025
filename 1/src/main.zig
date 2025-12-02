const std = @import("std");

const direction = enum { left, right };

var dial: i32 = 50;

var password: i32 = 0;

fn rotate(d: direction, a: i32) void {
    const amount = @rem(a, 100);

    switch (d) {
        .left => dial -= amount,
        .right => dial += amount,
    }

    if (dial < 0) {
        dial = 100 + dial;
    } else if (dial > 99) {
        dial = dial - 100;
    }

    if (dial == 0) {
        password += 1;
    }
}

pub fn main() !void {
    const file = std.fs.cwd().openFile("input", .{}) catch unreachable;
    defer file.close();

    var buffer: [256]u8 = undefined;
    var reader = file.reader(&buffer);

    while (try reader.interface.takeDelimiter('\n')) |line| {
        const dir = if (line[0] == 'L') direction.left else direction.right;
        const amount = std.fmt.parseInt(i32, line[1..], 10) catch unreachable;

        rotate(dir, amount);
    }

    std.debug.print("{}\n", .{password});
}
