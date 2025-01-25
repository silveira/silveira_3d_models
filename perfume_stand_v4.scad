
CUBE_EDGE = 15;
CUBES_PER_ROW = 5;
HOLE_RADIUS = 6;
HOLE_DEPTH_OFFSET = 2;
STEPS = 3;

module HoledCube() {
  difference() {
    translate([0,0, CUBE_EDGE/2])
      cube([CUBE_EDGE, CUBE_EDGE, CUBE_EDGE], center = true);
    
    translate([0, 0, HOLE_DEPTH_OFFSET]) 
      cylinder(CUBE_EDGE*2, HOLE_RADIUS, HOLE_RADIUS);
    
  }
}

module single_row() {
  for(i=[0: CUBES_PER_ROW-1])
    translate([i*CUBE_EDGE,0,0])
      HoledCube();
}

// all holed cubes
for(step=[0: STEPS-1])
  translate([0,step*CUBE_EDGE,step*CUBE_EDGE])
    single_row();

// stairs
translate([-CUBE_EDGE/2, CUBE_EDGE/2, 0])
  cube([CUBE_EDGE * CUBES_PER_ROW, CUBE_EDGE , CUBE_EDGE]);

translate([-CUBE_EDGE/2, 1.5*CUBE_EDGE, 0])
  cube([CUBE_EDGE * CUBES_PER_ROW, CUBE_EDGE , 2*CUBE_EDGE]);





