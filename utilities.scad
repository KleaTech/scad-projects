module screw_hole(screw_size) {
  translate([0, 0, -15])
  cylinder(h = 30, r = screw_size / 2);
}

module cut_piece(selection_size, selection_translate) {
  intersection() {
    translate(selection_translate)
    cube(selection_size);

    children(0);
  }
}
