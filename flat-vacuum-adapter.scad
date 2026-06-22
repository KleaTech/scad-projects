$fn = 50;

base_height = 30;
middle_height = 25;
top_height = 60;
wall_thickness = 2.5;
base_diameter = 35.6;
tip_width = 45;
tip_thickness = 20;

module tip() {
  tip_radius = (tip_thickness + (wall_thickness * 2)) / 2;
  translate([tip_radius - ((tip_width + (wall_thickness * 2)) / 2), 0, base_height + middle_height]) 
  hull() {
    cylinder(h = top_height, r = tip_radius);

    translate([tip_width + (wall_thickness * 2) - (tip_radius * 2), 0, 0]) 
    cylinder(h = top_height, r = tip_radius);
  }
}

module whole_part() {
  // Base
  base_radius = (base_diameter + (wall_thickness * 2)) / 2;
  cylinder(h = base_height, r = base_radius);

  // Middle
  hull() {
    translate([0, 0, base_height]) 
    linear_extrude(1)
    circle(base_radius);

    translate([0, 0, base_height + middle_height])
    linear_extrude(1)
    projection()
    tip();
  }

  // Top
  tip();
}

difference() {
  whole_part();

  // Top cutout
  translate([0, 10, base_height + middle_height + top_height -10 + 25])
  rotate([-30, 0, 0])
  cube(50, center = true);

  scale([base_diameter / (base_diameter + (wall_thickness * 2)),
        base_diameter / (base_diameter + (wall_thickness * 2)),
        1])
  whole_part();
}
