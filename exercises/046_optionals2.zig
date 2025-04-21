const std = @import("std");

const Elephant = struct {
    letter: u8,
    // Tail is now optional!
    tail: ?*Elephant = null,
    visited: bool = false,
};

pub fn main() void {
    var elephantA = Elephant{ .letter = 'A' };
    var elephantB = Elephant{ .letter = 'B' };
    var elephantC = Elephant{ .letter = 'C' };

    // Link the elephants so that each tail "points" to the next.
    linkElephants(&elephantA, &elephantB);
    linkElephants(&elephantB, &elephantC);
    // Elephant C's tail remains null, ending the chain.

    // `linkElephants` will stop the program if you try and link an
    // elephant that doesn't exist! Uncomment and see what happens.
    // const missingElephant: ?*Elephant = null;
    // linkElephants(&elephantC, missingElephant); // This would panic because missingElephant.? unwraps a null

    visitElephants(&elephantA);

    std.debug.print("\n", .{});
}

// If e1 and e2 are valid pointers to elephants,
// this function links the elephants so that e1's tail "points" to e2.
// Function parameters are optional pointers now.
fn linkElephants(e1: ?*Elephant, e2: ?*Elephant) void {
    // We use .? to assert that e1 and e2 are not null before assigning.
    // If either were null, the program would panic here.
    e1.?.tail = e2.?;
}

// This function visits all elephants once, starting with the
// first elephant and following the tails to the next elephant.
fn visitElephants(first_elephant: *Elephant) void {
    var e: *Elephant = first_elephant;

    while (!e.visited) {
        // Using {c} format specifier for characters
        std.debug.print("Elephant {c}. ", .{e.letter});
        e.visited = true;

        // If e.tail has a value (is not null), assign it to e.
        // Otherwise (orelse), break out of the loop.
        e = e.tail orelse break;
    }
}

