function jar_lid_thread_length(d, arc) = ((d * PI) / 360) * arc;
function jar_lid_thread_elevation(sdt, edt) = edt - sdt;
function jar_lid_thread_sin_x(sdt, edt, d, arc) = jar_lid_thread_elevation(sdt, edt) / jar_lid_thread_length(d, arc);
function jar_lid_thread_inclination(sdt, edt, d, arc) = asin(jar_lid_thread_sin_x(sdt, edt, d, arc));

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

module jar_lid_thread_profile(
    w, // jar thread width
    h // jar thread height
) {
    linear_extrude(1)
    hull() {
        square(0.1);
        translate([0, w]) square(0.1);
        translate([h, w / 2]) square(0.1);
    }
}

module jar_lid_thread(
    id, // jar_lid_side_wall_inner_diameter,
    od, // jar_lid_side_wall_outer_diameter,
    bt, // jar_lid_baseplate_thickness
    tw, // jar_thread_width
    th, // jar_thread_height
    arc, // thead arc in degrees
    tedt, // short end distance from top
    tsdt // thread start distance from top
) {
    inclination = jar_lid_thread_inclination(sdt = tsdt, edt = tedt, d = id, arc = arc);
    lid_h = tedt - tsdt;
    r = id / 2;
    thread_square_side = sqrt(pow(th / 2, 2) * 2);
    step = 1; // degrees
    for (i = [0 : step : arc]) {
        x = cos(i) * r;
        y = sin(i) * r;
        z = (lid_h / arc) * i;

        translate([0, 0, tsdt]) {
            translate([x, y, z]) rotate([90, 0, i]) rotate([-inclination, 180, 0]) jar_lid_thread_profile(w = tw, h = th);
        }
    }
}
