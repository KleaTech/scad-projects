$fn = 50;

thickness_near_screw = 10;
length_near_screw = 25;
thickness_near_angle = 10;
thickness_near_top = 10;
height = 30;
width = 25;
overall_length = 150;
top_length = 80;
screw_diameter = 6;

translate([-overall_length/2, 0, 0])
difference() {
  linear_extrude(width, center = true) {
    polygon([
      [0, 0],
      [0, thickness_near_screw],
      [length_near_screw, thickness_near_screw],
      [length_near_screw + (overall_length - top_length - (length_near_screw * 2))/2, height],
      [length_near_screw + (overall_length - top_length - (length_near_screw * 2))/2 + top_length, height],
      [overall_length - length_near_screw, thickness_near_screw],
      [overall_length, thickness_near_screw],
      [overall_length, 0],
      [overall_length - length_near_screw - thickness_near_angle, 0],
      [length_near_screw + (overall_length - top_length - (length_near_screw * 2))/2 + top_length - thickness_near_top, height - thickness_near_top],
      [length_near_screw + (overall_length - top_length - (length_near_screw * 2))/2 + thickness_near_top, height - thickness_near_top],
      [length_near_screw + thickness_near_angle, 0]
      ]);
  };

  rotate([90, 0, 0])
  translate([length_near_screw / 2, 0, 0])
  cylinder(d = screw_diameter, h = thickness_near_screw * 3, center = true);

  rotate([90, 0, 0])
  translate([overall_length - length_near_screw / 2, 0, 0])
  cylinder(d = screw_diameter, h = thickness_near_screw * 3, center = true);
}