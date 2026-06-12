use <flat-panel-joint.scad>;

side_width = 16;
side_height = 19;

inner_width = 408;
inner_height = 288;

outer_width = inner_width + side_width * 2;
outer_height = inner_height + side_height;
radius = 80;

module cover_shape() {
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

module screw_hole() {
  translate([0, 0, -15])
  cylinder(h = 30, r = 2);
}

module final_prototype() {
  difference() {
    union() {
      difference() {
        linear_extrude(4) {
          cover_shape();
        }

        translate([side_width, -side_height, -5])
        linear_extrude(10) {
          scale([
            inner_width / outer_width,
            inner_height / outer_height,
            1
          ])
          cover_shape();
        }
      }

      translate([side_width + 207, -(side_height - 16), 9])
      cube(10, center = true);
    }

    union() {
      translate([side_width - 9, -inner_height - 7, 0])
      screw_hole();

      translate([side_width + inner_width + side_width - 9, -inner_height - 7, 0])
      screw_hole();

      translate([inner_width - 20, -(side_height - 7), 0])
      screw_hole();

      translate([side_width + 207, -(side_height - 16), 0])
      screw_hole();
    }
  }
}

translate([40, 110, 0])
add_seam_to(joint_count = 1, translate_seam = [4, -200, 0]) {
  intersection() {
    translate([0, -400, -100])
    cube(200);

    final_prototype();
  }
}

add_seam_to(joint_count = 1, translate_seam = [90, -5, 0], rotate_seam = [0, 0, 270], invert_seam = true) {
  add_seam_to(joint_count = 1, translate_seam = [278, -200, 0], invert_seam = true) {
    mirror([1, 0, 0])
    translate([-290, 0, 0])
    intersection() {
      translate([0, -200, -100])
      cube(200);

      final_prototype();
    }
  }
}

add_seam_to(joint_count = 1, translate_seam = [255, -230, 0], rotate_seam = [0, 0, 180]) {
  add_seam_to(joint_count = 1, translate_seam = [20, -43, 0], rotate_seam = [0, 0, 90]) {
    translate([-180, -30, 0])
    intersection() {
      translate([200, -200, -100])
      cube(300);

      final_prototype();
    }
  }
}

add_seam_to(joint_count = 1, translate_seam = [100, -127, 0], rotate_seam = [0, 0, 270], invert_seam = true) {
  rotate([0, 0, 90])
  mirror([1, 0, 0])
  translate([-300, 100, 0])
  intersection() {
    translate([200, -500, -100])
    cube(300);

    final_prototype();
  }
}
