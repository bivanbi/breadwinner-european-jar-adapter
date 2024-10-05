use <../common/circle_sector.scad>

// units are in millimeters as measured with metric calipers, approximate values
function breadwinner_diameter() = 87.4;
function breadwinner_edge_height() = 3.5;
function breadwinner_center_sensor_hole_diameter() = 15.0;

function breadwinner_socket_skirt_wall_thickness() = 1.0;
function breadwinner_socket_baseplate_thickness() = 1.0;

function breadwinner_socket_outer_diameter() = breadwinner_diameter() + 2 * breadwinner_socket_skirt_wall_thickness();

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

breadwinner_socket();
