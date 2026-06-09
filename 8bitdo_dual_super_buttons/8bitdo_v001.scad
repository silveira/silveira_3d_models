// Box enclosure for 160x74x18mm object

// Inner dimensions (the object to enclose)
inner_length = 160;
inner_width = 74;
inner_height = 18;

// Wall thickness
wall = 2;

// Outer dimensions
outer_length = inner_length + 2 * wall;
outer_width = inner_width + 2 * wall;
outer_height = inner_height + wall; // wall on bottom only, open top

difference() {
    // Outer shell
    cube([outer_length, outer_width, outer_height]);

    // Inner cavity
    translate([wall, wall, wall])
        cube([inner_length, inner_width, inner_height + 1]); // +1 to cut through top
}
