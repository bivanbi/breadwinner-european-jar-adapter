use <breadwinner.scad>

function breadwinner_glue_aid_center_ring_diameter() = breadwinner_center_sensor_hole_diameter();
function breadwinner_glue_aid_center_ring_height() = breadwinner_socket_baseplate_thickness() * 2;
function breadwinner_glue_aid_center_ring_wall_thickness() = 1.0;
function breadwinner_glue_aid_center_ring_rim_overhang() = 1.0;
function breadwinner_glue_aid_center_ring_rim_thickness() = 1.0;

// To help when gluing together the Breadwinner socket with the jar lid
module breadwinner_glue_aid_centering_ring(
    d = breadwinner_glue_aid_center_ring_diameter(),
    h = breadwinner_glue_aid_center_ring_height(),
    t = breadwinner_glue_aid_center_ring_wall_thickness(),
    rim_o = breadwinner_glue_aid_center_ring_rim_overhang(),
    rim_t = breadwinner_glue_aid_center_ring_rim_thickness()
) {
    rim_offset_x = d / 2 - t;
    rim_offset_y = - rim_t;
    rim_o = rim_o + t;

    ring_offset_x = d / 2 - t;
    ring_w = t;

    round_tip_offset_x = ring_offset_x + t / 2;

    rotate_extrude() {
        union() {
            translate([rim_offset_x, rim_offset_y]) square([rim_o, rim_t], center = false);
            translate([ring_offset_x, 0]) square([ring_w, h], center = false);
            translate([round_tip_offset_x, h]) circle(d = ring_w);
        }
    }
}

breadwinner_glue_aid_centering_ring();