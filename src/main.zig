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
    try addTask("To study");
    try addTask("To Dance");

    listTasks();
    try makeAsComplete(1);
    listTasks();
}

fn addTask(title: []const u8) !void {
    const new_task = Task{ .id = @intCast(tasks.items.len + 1), .title = title, .completed = false };

    // Add to tasks array list
    try tasks.append(new_task);
}

fn makeAsComplete(id: u32) !void {
    for (tasks.items) |*task| {
        if (task.id == id) {
            task.completed = true;
            return;
        }
    }
    std.debug.print("Task with ID {d} not found", .{id});
}

fn listTasks() void {
    if (tasks.items.len == 0) {
        std.debug.print("No task exist yet!\n", .{});
    }

    for (tasks.items) |task| {
        std.debug.print("ID: {d}, Title: {s}, Completed: {s}\n", .{ task.id, task.title, if (task.completed) "Yes" else "No" });
    }
}
