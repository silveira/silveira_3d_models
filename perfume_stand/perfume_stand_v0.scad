
SINGLE_CUBE_WIDTH = 15;

module HoledCube() {
    step_width = SINGLE_CUBE_WIDTH;
    step_depth = SINGLE_CUBE_WIDTH;
    step_height = SINGLE_CUBE_WIDTH;

    difference() {
        translate([0,0, step_height/2]){
            cube([step_width, step_depth, step_height], center = true);
        }
        translate([0, 0, 2]) {
            cylinder(step_height*2, 6, 6);
        }
    }
}

 HoledCube();

// single row 
/*
cubes_per_row = 5;
for(i=[0: cubes_per_row]) {
    translate([i*SINGLE_CUBE_WIDTH,0,0]){
        HoledCube();
    }   
}*/
