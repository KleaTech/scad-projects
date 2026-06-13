use <flat-panel-joint.scad>;
use <utilities.scad>;
//$fn = 50;

side_width = 16;
side_height = 19;

inner_width = 408;
inner_height = 287;

outer_width = inner_width + side_width * 2;
outer_height = inner_height + side_height;
inner_radius = 80;
outer_radius = 100;

module cover_shape(radius) {
  translate([radius, -radius, 0]) 
  circle(radius);

  rad_midpoint_dist = outer_width - radius - radius;
  translate([radius, -radius -radius, 0])
  square([rad_midpoint_dist, radius * 2]);

  translate([outer_width - radius, -radius, 0])
  circle(radius);

  translate([0, -outer_height, 0]) 
  square([outer_width, outer_height - radius]);
}

module final_prototype() {
  difference() {
    union() {
      difference() {
        // Cover outer shape
        linear_extrude(4)
        cover_shape(outer_radius);

        // Cover inner shape
        translate([side_width, -side_height, -5])
        linear_extrude(10)
        scale([inner_width / outer_width, inner_height / outer_height, 1])
        cover_shape(inner_radius);
      }

      translate([side_width + 207, -(side_height - 16) -1.5, 9])
      cube([10, 9, 10], center = true);
    }

    union() {
      // Lower left
      translate([side_width - 9, -inner_height - 9, 0])
      screw_hole(4);

      // Lower right
      translate([side_width + inner_width + side_width - 9, -inner_height - 9, 0])
      screw_hole(4);

      // Corner
      translate([inner_width, -(side_height + 13), 0])
      screw_hole(4);

      // Top
      translate([side_width + 207, -(side_height - 16), 0])
      screw_hole(4);
    }
  }
}

// Lower left
translate([80, 110, 0])
mirror([1, 0, 0])
add_seam_to(joint_count = 1, translate_seam = [12, -200, 0], rotate_seam = [0, 0, 180], invert_seam = true)
cut_piece(200, [0, -400, -100])
final_prototype();

// Upper left
translate([30, -30, 0])
add_seam_to(joint_count = 1, translate_seam = [200, -5, 0], rotate_seam = [0, 0, 270])
add_seam_to(joint_count = 1, translate_seam = [12, -200, 0], rotate_seam = [0, 0, 180])
cut_piece(200, [0, -200, -100])
final_prototype();

// Upper right
mirror([1, 0, 0])
translate([-450, 0, 0])
add_seam_to(joint_count = 1, translate_seam = [200, -5, 0], rotate_seam = [0, 0, 270], invert_seam = true)
add_seam_to(joint_count = 1, translate_seam = [428, -200, 0], invert_seam = true)
cut_piece(300, [200, -200, -100])
final_prototype();

// Lower right
translate([-300, 100, 0])
add_seam_to(joint_count = 1, translate_seam = [428, -200, 0])
cut_piece(300, [200, -500, -100])
final_prototype();
