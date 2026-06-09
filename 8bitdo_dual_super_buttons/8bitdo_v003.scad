// Box enclosure for 160x74x18mm object

// Inner dimensions (the object to enclose)
inner_length = 160;
inner_width = 74;
inner_height = 18;

// Wall thickness
wall = 2;

// Bottom hole inset from inner walls
hole_inset = 3;

// Side hole dimensions
side_hole_width = 10;
side_hole_height = 8;

// Outer dimensions
outer_length = inner_length + 2 * wall;
outer_width = inner_width + 2 * wall;
outer_height = inner_height + wall; // wall on bottom only, open top

// Bottom hole dimensions
hole_length = inner_length - 2 * hole_inset;
hole_width = inner_width - 2 * hole_inset;

difference() {
    // Outer shell
    cube([outer_length, outer_width, outer_height]);

    // Inner cavity
    translate([wall, wall, wall])
        cube([inner_length, inner_width, inner_height + 1]);

    // Square hole in the bottom
    translate([wall + hole_inset, wall + hole_inset, -1])
        cube([hole_length, hole_width, wall + 2]);

    // Hole on the long side (front), centered horizontally, near top edge
    translate([outer_length / 2 - side_hole_width / 2, -1, outer_height - side_hole_height])
        cube([side_hole_width, wall + 2, side_hole_height + 1]);
}
