CUBE_EDGE = 15;
CELLS_PER_ROW = 5;
HOLE_RADIUS = 6;
HOLE_DEPTH_OFFSET = 2;
STEPS = 3;

module stairs()
  for(i=[0:STEPS-1])
    translate([0,i*CUBE_EDGE,0])
      cube([CUBE_EDGE * CELLS_PER_ROW,
            CUBE_EDGE,
            (i+1) * CUBE_EDGE
           ]);

module holes()
  for(i=[0: STEPS - 1])
    for(j=[0: CELLS_PER_ROW - 1])
      translate([CUBE_EDGE/2 + j*CUBE_EDGE,
                 CUBE_EDGE/2 + i*CUBE_EDGE,
                 HOLE_DEPTH_OFFSET + i*CUBE_EDGE
                ])
        cylinder(CUBE_EDGE*2, HOLE_RADIUS, HOLE_RADIUS);

difference(){
  stairs();
  holes();
}
