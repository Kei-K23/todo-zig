const std = @import("std");
const ArrayList = std.ArrayList;

const Task = struct { id: u32, title: []const u8, completed: bool };

var tasks: ArrayList(Task) = undefined;

const version = "0.1.0";

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    tasks = ArrayList(Task).init(allocator);

    defer tasks.deinit();

    const stdOut = std.io.getStdOut().writer();

    try stdOut.print("Todo List CLI - Zig (Version : {s})\n", .{version});
}
