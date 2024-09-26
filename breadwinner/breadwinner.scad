
// units are in millimeters as measured with metric calipers, approximate values
function breadwinner_diameter() = 87.4;
function breadwinner_edge_height() = 4.0;
function breadwinner_center_sensor_hole_diameter() = 15.0;

function breadwinner_socket_skirt_wall_thickness() = 1.0;
function breadwinner_socket_baseplate_thickness() = 1.0;

module breadwinner_socket(bt = breadwinner_socket_baseplate_thickness(), wt = breadwinner_socket_skirt_wall_thickness()) {
    baseplate_w = (breadwinner_diameter() - breadwinner_center_sensor_hole_diameter()) / 2;
    
    baseplate_offset_x = breadwinner_center_sensor_hole_diameter() / 2;
    skirt_offset_x = baseplate_offset_x + baseplate_w;
    skirt_h = breadwinner_edge_height() + bt;
    
    rotate_extrude() {
        union() {
            translate([baseplate_offset_x, 0]) square([baseplate_w, bt], center = false);
            translate([skirt_offset_x, 0]) square([wt, skirt_h], center = false);
        }
    }
}

function breadwinner_glue_aid_center_ring_baseplate_diameter() = 40.0;
function breadwinner_glue_aid_center_ring_baseplate_thickness() = 1.0;
function breadwinner_glue_aid_center_ring_height() = breadwinner_socket_baseplate_thickness() * 2;
function breadwinner_glue_aid_center_ring_skirt_wall_thickness() = 1.0;

// To help when gluing together the Breadwinner socket with the jar lid
module breadwinner_glue_aid_centering_ring(h = breadwinner_glue_aid_center_ring_height(), baseplate_thickness = breadwinner_glue_aid_center_ring_baseplate_thickness()) {
    baseplate_w = breadwinner_glue_aid_center_ring_baseplate_diameter() / 2;

    skirt_offset_x = breadwinner_center_sensor_hole_diameter() / 2 - breadwinner_glue_aid_center_ring_skirt_wall_thickness();
    skirt_offset_y = baseplate_thickness;
    skirt_w = breadwinner_glue_aid_center_ring_skirt_wall_thickness();
    skirt_round_top_offset_x = skirt_offset_x + skirt_w / 2;
    skirt_round_top_offset_y = baseplate_thickness + h;

    rotate_extrude() {
        union() {
            square([baseplate_w, baseplate_thickness], center = false);
            translate([skirt_offset_x, baseplate_thickness]) square([skirt_w, h], center = false);
            translate([skirt_round_top_offset_x, skirt_round_top_offset_y]) circle(d = skirt_w);
        }
    }
}

color("lightblue") breadwinner_socket();
translate([0, 0, - breadwinner_glue_aid_center_ring_baseplate_thickness()]) breadwinner_glue_aid_centering_ring();
