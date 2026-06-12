use <flat-panel-joint.scad>;

add_seam_to(joint_count = 7, translate_seam = [0, -50, 0], rotate_seam = [0, 0, 90]) {
    translate([0, -50, 0])
    cube([50, 80, 4]);
};

mirror([1, 0, 0]) {
    add_seam_to(joint_count = 7, translate_seam = [20, 30, 0], rotate_seam = [0, 0, 270], invert_seam = true) {
        translate([20, -50, 0])
        cube([50, 80, 4]);
    };
};
