height = 2;
radius = 20;

difference() {
    cylinder(height, radius, radius, $fn=6);
    translate([-radius,0,-radius/4]){
        cube([radius*2, radius, radius]);
    }    
}