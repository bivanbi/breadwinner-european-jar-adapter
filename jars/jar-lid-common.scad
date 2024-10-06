module jar_baseplate(
    od, // outer diameter
    chd, // center sensor hole diameter
    t // thickness
) {
    linear_extrude(height = t) {
        difference() {
            circle(d = od);
            circle(d = chd);
        }
    }
}

module jar_lid_side_wall(
    od, // outer diameter
    id, // inner diameter,
    h, // height
    ribbed = true
) {
    rib_od = od + 1;
    // a^^2 * 2= c^^2
    rib_square_side = sqrt(pow(rib_od / 2, 2) * 2);

    linear_extrude(height = h) {
        union() {
            difference() {
                union() {
                    //circle(d = od);
                    if (ribbed == true) {
                        for (i = [0 : 2 : 90])
                        rotate([0, 0, i]) {
                            square(rib_square_side, center = true);
                        }
                    } else {
                        circle(d = od);
                    }
                }
                circle(d = id);
            }
        }
    }
}
