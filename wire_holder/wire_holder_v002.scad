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
        // Left overhang (mounts to surface)
        translate([0, 0, 0])
            cube([overhang_width, overhang_length, overhang_thickness]);

        // Right overhang (mounts to surface)
        translate([0, overhang_length + bridge_span, 0])
            cube([overhang_width, overhang_length, overhang_thickness]);

        // Bridge connecting the two overhangs below
        translate([0, overhang_length, -gusset_height])
            cube([bridge_width, bridge_span, bridge_thickness]);

        // Gussets - left overhang (two gussets bracing down to bridge)
        translate([0, overhang_length, -gusset_height])
            mirror([0, 1, 0])
                gusset(overhang_length, gusset_height, gusset_thickness);
        translate([overhang_width - gusset_thickness, overhang_length, -gusset_height])
            mirror([0, 1, 0])
                gusset(overhang_length, gusset_height, gusset_thickness);

        // Gussets - right overhang (two gussets bracing down to bridge)
        translate([0, overhang_length + bridge_span, -gusset_height])
            gusset(overhang_length, gusset_height, gusset_thickness);
        translate([overhang_width - gusset_thickness, overhang_length + bridge_span, -gusset_height])
            gusset(overhang_length, gusset_height, gusset_thickness);
    }

    // Screw holes in overhang tabs
    translate([overhang_width / 2, overhang_length / 2, -1])
        cylinder(h = overhang_thickness + 2, d = screw_hole_d, $fn = 32);
    translate([overhang_width / 2, overhang_length + bridge_span + overhang_length / 2, -1])
        cylinder(h = overhang_thickness + 2, d = screw_hole_d, $fn = 32);
}
