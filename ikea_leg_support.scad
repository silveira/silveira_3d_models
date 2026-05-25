// millimeters
leg_width = 52; // front
leg_depth = 44;
distance_to_floor = 22;
// MEASURE AGAIN

piece_heigh = 30;

padding = 5;

// TODO: measure again;

translate([0,0,piece_heigh/2]) {  
  difference(){
    cube([leg_width+padding*2, leg_depth+padding*2, piece_heigh], center=true);
    
    translate([0,0,distance_to_floor])
      cube([leg_width, leg_depth, piece_heigh], center=true);
  }
}
