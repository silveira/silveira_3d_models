// Box enclosure for 160x74x18mm object

// Inner dimensions (the object to enclose)
inner_length = 160;
inner_width = 74;
inner_height = 18;

// Wall thickness
wall = 2;

// Bottom hole inset from inner walls
hole_inset = 3;

// Bottom hole corner radius
hole_corner_radius = 3;

// Side hole dimensions
side_hole_width = 10;
side_hole_height = 8;
side_hole_corner_radius = 2;

// Overhang dimensions
overhang_width = 15;
overhang_length = 15;

// Screw hole diameter
screw_hole_d = 3;

// Gusset dimensions
gusset_thickness = 2;
gusset_height = 10;

// Outer dimensions
outer_length = inner_length + 2 * wall;
outer_width = inner_width + 2 * wall;
outer_height = inner_height + wall; // wall on bottom only, open top

// Bottom hole dimensions
hole_length = inner_length - 2 * hole_inset;
hole_width = inner_width - 2 * hole_inset;

// Overhang positions along X (flush to edges)
overhang_x1 = 0;
overhang_x2 = outer_length - overhang_width;

// Rounded rectangle module
module rounded_rect(length, width, height, radius) {
    translate([radius, radius, 0])
        hull() {
            cylinder(h = height, r = radius, $fn = 32);
            translate([length - 2 * radius, 0, 0])
                cylinder(h = height, r = radius, $fn = 32);
            translate([0, width - 2 * radius, 0])
                cylinder(h = height, r = radius, $fn = 32);
            translate([length - 2 * radius, width - 2 * radius, 0])
                cylinder(h = height, r = radius, $fn = 32);
        }
}

// Gusset module: right-triangle brace
module gusset(length, height, thickness) {
    hull() {
        cube([thickness, 0.01, height]);
        translate([0, length - 0.01, height - 0.01])
            cube([thickness, 0.01, 0.01]);
    }
}

difference() {
    union() {
        // Outer shell
        cube([outer_length, outer_width, outer_height]);

        // Left side overhangs (Y=0, extending in -Y)
        translate([overhang_x1, -overhang_length, outer_height - wall])
            cube([overhang_width, overhang_length, wall]);
        translate([overhang_x2, -overhang_length, outer_height - wall])
            cube([overhang_width, overhang_length, wall]);

        // Right side overhangs (Y=outer_width, extending in +Y)
        translate([overhang_x1, outer_width, outer_height - wall])
            cube([overhang_width, overhang_length, wall]);
        translate([overhang_x2, outer_width, outer_height - wall])
            cube([overhang_width, overhang_length, wall]);

        // Gussets - left side, front overhang
        translate([overhang_x1, 0, outer_height - wall - gusset_height])
            mirror([0, 1, 0])
                gusset(overhang_length, gusset_height, gusset_thickness);
        translate([overhang_x1 + overhang_width - gusset_thickness, 0, outer_height - wall - gusset_height])
            mirror([0, 1, 0])
                gusset(overhang_length, gusset_height, gusset_thickness);

        // Gussets - left side, rear overhang
        translate([overhang_x2, 0, outer_height - wall - gusset_height])
            mirror([0, 1, 0])
                gusset(overhang_length, gusset_height, gusset_thickness);
        translate([overhang_x2 + overhang_width - gusset_thickness, 0, outer_height - wall - gusset_height])
            mirror([0, 1, 0])
                gusset(overhang_length, gusset_height, gusset_thickness);

        // Gussets - right side, front overhang
        translate([overhang_x1, outer_width, outer_height - wall - gusset_height])
            gusset(overhang_length, gusset_height, gusset_thickness);
        translate([overhang_x1 + overhang_width - gusset_thickness, outer_width, outer_height - wall - gusset_height])
            gusset(overhang_length, gusset_height, gusset_thickness);

        // Gussets - right side, rear overhang
        translate([overhang_x2, outer_width, outer_height - wall - gusset_height])
            gusset(overhang_length, gusset_height, gusset_thickness);
        translate([overhang_x2 + overhang_width - gusset_thickness, outer_width, outer_height - wall - gusset_height])
            gusset(overhang_length, gusset_height, gusset_thickness);
    }

    // Inner cavity
    translate([wall, wall, wall])
        cube([inner_length, inner_width, inner_height + 1]);

    // Rounded square hole in the bottom
    translate([wall + hole_inset, wall + hole_inset, -1])
        rounded_rect(hole_length, hole_width, wall + 2, hole_corner_radius);

    // Rounded hole on the long side (front), centered horizontally, near top edge
    translate([outer_length / 2 - side_hole_width / 2, -1, outer_height - side_hole_height])
        rotate([-90, 0, 0])
            rounded_rect(side_hole_width, side_hole_height + 1, wall + 2, side_hole_corner_radius);

    // Screw holes in overhangs - left side
    translate([overhang_x1 + overhang_width / 2, -overhang_length / 2, outer_height - wall - 1])
        cylinder(h = wall + 2, d = screw_hole_d, $fn = 32);
    translate([overhang_x2 + overhang_width / 2, -overhang_length / 2, outer_height - wall - 1])
        cylinder(h = wall + 2, d = screw_hole_d, $fn = 32);

    // Screw holes in overhangs - right side
    translate([overhang_x1 + overhang_width / 2, outer_width + overhang_length / 2, outer_height - wall - 1])
        cylinder(h = wall + 2, d = screw_hole_d, $fn = 32);
    translate([overhang_x2 + overhang_width / 2, outer_width + overhang_length / 2, outer_height - wall - 1])
        cylinder(h = wall + 2, d = screw_hole_d, $fn = 32);
}
