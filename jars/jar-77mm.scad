use <../breadwinner/breadwinner.scad>
use <jar-lid-common.scad>

function jar_opening_outer_diameter() = 77.55; // 77.55mm
function jar_thread_height() = 1.5; // protruding from the jar opening surface this much
function jar_thread_width() = 3.0;
function jar_opening_diameter_with_thread() = 81.0;
function jar_sink_direction() = "clockwise";
function jar_thread_count() = 6;
function jar_thread_short_long_array() = ["short", "long", "long", "short", "long", "long"]; // There are 6 threads, but there are two different thread lenghts! Order matters!
function jar_thread_base_thickness() = 3.0;
function jar_thread_start_distance_from_top() = 6.0; // as measured at the edge of the thread
function jar_thread_short_end_distance_from_top() = 9.0;
function jar_thread_long_end_distance_from_top() = 10.5;
function jar_thread_short_arc() = 50; // degrees
function jar_thread_long_arc() = 70; // degrees

function jar_lid_baseplate_thickness() = 1.0;
function jar_center_sensor_hole_diameter() = breadwinner_center_sensor_hole_diameter();
function jar_side_wall_height() = jar_thread_long_end_distance_from_top() + 2;

function jar_lid_thread_median_distance_from_top() = (jar_thread_start_distance_from_top() + jar_thread_short_end_distance_from_top()) / 2;
function jar_lid_thread_arc() = jar_thread_short_arc(); // degrees

function jar_lid_diameter_loose_tolerance() = 0.5;
function jar_lid_side_wall_inner_diameter() = jar_opening_diameter_with_thread() + jar_lid_diameter_loose_tolerance();
function jar_lid_side_wall_outer_diameter() = max(jar_lid_side_wall_inner_diameter() + 3, breadwinner_socket_outer_diameter());
function jar_lid_outer_diameter() = max(breadwinner_diameter(), jar_lid_side_wall_outer_diameter());

module jar_lid(
    bt = jar_lid_baseplate_thickness(),
    id = jar_lid_side_wall_inner_diameter(),
    od = jar_lid_side_wall_outer_diameter(),
    threaded = true,
    ribbed = true
) {
    union() {
        jar_baseplate(od = od, chd = jar_center_sensor_hole_diameter(), t = bt);
        jar_lid_side_wall(od = od, id = id, h = jar_side_wall_height(), ribbed = ribbed);
        if (threaded == true)
        for (i = [0 : jar_thread_count() - 1]) {
            angle = i * 360 / jar_thread_count();
            rotate([0, 0, angle])
            jar_lid_thread(
                id = id,
                od = od,
                bt = jar_thread_base_thickness(),
                tw = jar_thread_width(),
                th = jar_thread_height(),
                tedt = jar_thread_short_end_distance_from_top(),
                tsdt = jar_thread_start_distance_from_top(),
                arc = jar_thread_short_arc()
            );
        }
    }
}

jar_lid();
