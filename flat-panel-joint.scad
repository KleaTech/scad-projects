/* 
 * Based on a work at https://skfb.ly/p8Zyr.
 * "Flat panel joint part 1" (https://skfb.ly/p8Zyr) by payo@TensileCreator is licensed under Creative Commons Attribution-NonCommercial (http://creativecommons.org/licenses/by-nc/4.0/).
 */

/*
 * Usage example:
 * add_seam_to(joint_count = 7, translate_seam = [0, -50, 0], rotate_seam = [0, 0, 90]) {
 *   translate([0, -50, 0])
 *   cube([50, 80, 4]);
 * };
 *
 * mirror([1, 0, 0]) {
 *   add_seam_to(joint_count = 7, translate_seam = [20, 30, 0], rotate_seam = [0, 0, 270], invert_seam = true) {
 *     translate([20, -50, 0])
 *     cube([50, 80, 4]);
 *   };
 * };
 */
module add_seam_to(joint_count, translate_seam = [0, 0, 0], rotate_seam = [0, 0, 0], scale_xy = 1, z_height = 4, invert_seam = false) {
    joint_spacing=21;
    tolerance=0.05;
    first_iteration_count = ceil(joint_count / 2) - 1;
    second_iteration_count = max(floor(joint_count / 2) - 1, 0);

    union() {
        difference() {
            children(0);
            if (invert_seam || joint_count > 1) {
                translate(translate_seam)
                rotate(rotate_seam)
                for (i=[0:(invert_seam ? first_iteration_count : second_iteration_count)]) {
                    translate([(i * joint_spacing * scale_xy) + (invert_seam ? (8 * scale_xy) : (10.5 * scale_xy)), 0, 0])
                    rotate([0, 0, invert_seam ? 180 : 0])
                    union() {
                        translate([1.5 * scale_xy - tolerance, -4 * scale_xy, z_height / 2])
                        cube([5 * scale_xy + (tolerance*2), 4 * scale_xy + tolerance, (z_height / 2) + tolerance]);
                        translate([0 - tolerance, -7 * scale_xy - tolerance, 0 - tolerance])
                        cube([8 * scale_xy + (tolerance*2), 3 * scale_xy + (tolerance*2), z_height + (tolerance*2)]);
                    }
                }
            }
        }
        if (!invert_seam || joint_count > 1) {
            translate(translate_seam)
            rotate(rotate_seam)
            for (i=[(invert_seam ? 1 : 0):(invert_seam ? second_iteration_count : first_iteration_count)]) {
                translate([(i * joint_spacing * scale_xy), 0, 0])
                rotate([0, 0, invert_seam ? 180 : 0])
                union() {
                    translate([1.5 * scale_xy, 0, 0])
                    cube([5 * scale_xy, 4 * scale_xy, (z_height / 2)]);
                    translate([0, 4 * scale_xy, 0])
                    cube([8 * scale_xy, 3 * scale_xy, z_height]);
                }
            }
        }
    }
}
