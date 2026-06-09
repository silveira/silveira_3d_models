// Wire holder: two overhangs with triangular gussets connected by a bridge
// Based on 8bitdo_v013 overhang/gusset dimensions

// Overhang dimensions (from 8bitdo reference)
overhang_width = 15;
overhang_length = 15;
overhang_thickness = 2;

// Gusset dimensions
gusset_thickness = 2;
gusset_height = 10;

// Screw hole
screw_hole_d = 3;

// Bridge dimensions
bridge_span = 30;       // distance between the two overhangs
bridge_thickness = 2;
bridge_width = 15;      // same as overhang_width

// Mounting plate (attaches to surface, connects both overhangs)
plate_width = overhang_width;
plate_length = bridge_span + 2 * overhang_length;
plate_thickness = overhang_thickness;

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
        // Mounting plate (flat against surface, e.g. underside of desk)
        cube([plate_width, plate_length, plate_thickness]);

        // Left overhang (extends down from plate)
        translate([0, 0, -gusset_height - bridge_thickness])
            cube([overhang_width, overhang_length, bridge_thickness]);

        // Right overhang (extends down from plate)
        translate([0, plate_length - overhang_length, -gusset_height - bridge_thickness])
            cube([overhang_width, overhang_length, bridge_thickness]);

        // Bridge connecting the two overhangs
        translate([0, overhang_length, -gusset_height - bridge_thickness])
            cube([bridge_width, bridge_span, bridge_thickness]);

        // Gussets - left overhang (two gussets at each edge of the overhang width)
        translate([0, overhang_length, -gusset_height])
            mirror([0, 1, 0])
                gusset(overhang_length, gusset_height, gusset_thickness);
        translate([overhang_width - gusset_thickness, overhang_length, -gusset_height])
            mirror([0, 1, 0])
                gusset(overhang_length, gusset_height, gusset_thickness);

        // Gussets - right overhang (two gussets at each edge of the overhang width)
        translate([0, plate_length - overhang_length, -gusset_height])
            gusset(overhang_length, gusset_height, gusset_thickness);
        translate([overhang_width - gusset_thickness, plate_length - overhang_length, -gusset_height])
            gusset(overhang_length, gusset_height, gusset_thickness);
    }

    // Screw holes in mounting plate
    translate([plate_width / 2, overhang_length / 2, -1])
        cylinder(h = plate_thickness + 2, d = screw_hole_d, $fn = 32);
    translate([plate_width / 2, plate_length - overhang_length / 2, -1])
        cylinder(h = plate_thickness + 2, d = screw_hole_d, $fn = 32);
}
