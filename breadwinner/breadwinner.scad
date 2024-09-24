
// units are in millimeters as measured with metric calipers, approximate values
function breadwinner_diameter() = 87.4;
function breadwinner_edge_height() = 4.0;
function breadwinner_center_sensor_hole_diameter() = 15.0;

function default_wall_thickness() = 1.0;

module breadwinner_socket(t = default_wall_thickness()) {
    baseplate_w = (breadwinner_diameter() - breadwinner_center_sensor_hole_diameter()) / 2 + t ;
    
    baseplate_offset_x = breadwinner_center_sensor_hole_diameter() / 2;
    skirt_offset_x = baseplate_offset_x + baseplate_w;
    skirt_h = breadwinner_edge_height() + t;
    
    rotate_extrude() {
        union() {
            translate([baseplate_offset_x, 0]) square([baseplate_w, t], center = false);
            translate([skirt_offset_x, 0]) square([t, skirt_h], center = false);
        }
    }
}

breadwinner_socket();