h_width = 100; // doboz szélessége
h_depth = 100; // doboz mélysége
h_height = 50; // doboz magassága
h_diameter = 25; // antenna cső átmérője
h_wall_thickness = 2; // falvastagság
h_fixture_width = 30; // rögzítő szélessége

translate([0, 0, (h_height / 2) + h_wall_thickness]) 
difference() {
  // doboz és rögzítő fala
  union() {
    cube([h_width + 2 * h_wall_thickness, h_depth + 2 * h_wall_thickness, h_height + h_wall_thickness], center = true);
    translate([0, 0, (h_height + h_wall_thickness) / 2]) 
    rotate([90, 0, 0])
    cylinder(h = h_width + h_fixture_width * 2 + h_wall_thickness * 2, r = h_diameter / 2 + h_wall_thickness, center = true);
  }

  // doboz belső terének törlése
  translate([0, 0, h_wall_thickness]) 
  cube([h_width, h_depth, h_height], center = true);
  
  // doboz feletti rész törlése
  translate([0, 0, h_height]) 
  cube([h_width * 2, h_depth * 2, h_diameter * 2], center = true);

  // antenna cső helyének törlése
  translate([0, 0, (h_height + h_wall_thickness) / 2]) 
  rotate([90, 0, 0])
  cylinder(h = h_width + h_fixture_width * 3, r = h_diameter / 2, center = true);
}
