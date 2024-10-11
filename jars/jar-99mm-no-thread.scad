// This is not a standard jar, as it has no 'thread'.
// It had a glass top with a metallic frame to secure it to the jar.

use <../breadwinner/breadwinner.scad>
use <jar-lid-common.scad>

function jar_opening_outer_diameter() = 99.00; // 77.55mm
function jar_side_wall_height() = 23.00;

function jar_lid_side_wall_inner_diameter() = jar_opening_outer_diameter();
function jar_lid_side_wall_outer_diameter() = max(jar_lid_side_wall_inner_diameter() + 3, breadwinner_socket_outer_diameter());

function jar_lid_baseplate_thickness() = 1.0;
function jar_center_sensor_hole_diameter() = breadwinner_center_sensor_hole_diameter();

module jar_lid(
    bt = jar_lid_baseplate_thickness(),
    id = jar_lid_side_wall_inner_diameter(),
    od = jar_lid_side_wall_outer_diameter(),
    ribbed = true
) {
    union() {
        jar_baseplate(od = od, chd = jar_center_sensor_hole_diameter(), t = bt);
        jar_lid_side_wall(od = od, id = id, h = jar_side_wall_height(), ribbed = ribbed);
    }
}

jar_lid();
