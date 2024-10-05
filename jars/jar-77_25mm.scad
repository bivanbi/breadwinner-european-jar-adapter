use <../breadwinner/breadwinner.scad>

function jar_opening_outer_diameter() = 77.55; // 77.25mm
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

function jar_baseplate_thickness() = 1.0;
function jar_side_wall_outer_diameter() = breadwinner_diameter(); // breadwinner is larger, so it will be the outer diameter
function jar_center_sensor_hole_diameter() = breadwinner_center_sensor_hole_diameter();
function jar_side_wall_height() = jar_thread_long_end_distance_from_top() + 2;

function jar_lid_thread_median_distance_from_top() = (jar_thread_start_distance_from_top() + jar_thread_short_end_distance_from_top()) / 2;
function jar_lid_thread_arc() = jar_thread_short_arc(); // degrees

function jar_lid_thread_step_distance(d, step) = PI * d / step; // step in degrees
function jar_lid_thread_length(d) = ((d * PI) / 360) * jar_thread_short_arc();
function jar_lid_thread_elevation() = jar_thread_short_end_distance_from_top() - jar_thread_start_distance_from_top();
function jar_lid_thread_sin_x(d) = jar_lid_thread_elevation() / jar_lid_thread_length(d);
function jar_lid_thread_inclination(d) = asin(jar_lid_thread_sin_x(d));

// emelkedés: jar_thread_long_end_distance_from_top() - jar_thread_start_distance_from_top()
// hossz = ((d * PI) / 360) * jar_thread_long_arc()

// sin x = emelkedes / jar_thread_long_arc
function jar_lid_thread_inclination(d) = PI * d / jar_lid_thread_arc(); // degrees

module jar_baseplate(od = jar_side_wall_outer_diameter(), chd = jar_center_sensor_hole_diameter(), t = jar_baseplate_thickness()) {
    linear_extrude(height = t) {
        difference() {
            circle(d = od);
            circle(d = chd);
        }
    }
}

module jar_side_wall(
    od = jar_side_wall_outer_diameter(),
    id = jar_opening_outer_diameter(),
    h = jar_side_wall_height(),
    chd = jar_center_sensor_hole_diameter(),
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

module jar_lid_thread_profile() {
    linear_extrude(1)
    hull() {
        square(0.1);
        translate([0, jar_thread_width()]) square(0.1);
        translate([jar_thread_height(), jar_thread_width() / 2]) square(0.1);
    }
}

module jar_lid_thread(bt = jar_baseplate_thickness()) {
    inclination = jar_lid_thread_inclination(jar_opening_outer_diameter());
    arc = jar_thread_short_arc();
    lid_h = jar_thread_short_end_distance_from_top() - jar_thread_start_distance_from_top();
    r = jar_opening_outer_diameter() / 2;
    thread_square_side = sqrt(pow(jar_thread_height() / 2, 2) * 2);
    step = 1; // degrees
    for (i = [0 : step : arc]) {
        x = cos(i) * r;
        y = sin(i) * r;
        z = (lid_h / arc) * i;

        translate([0, 0, jar_thread_start_distance_from_top()]) {
            translate([x, y, z]) rotate([90, 0, i]) rotate([-inclination, 180, 0]) jar_lid_thread_profile();
        }
    }
}

module jar_lid(bt = jar_baseplate_thickness(), od = jar_side_wall_outer_diameter(), ribbed = true) {
    union() {
        jar_baseplate(t = bt);
        jar_side_wall(od = od, ribbed = false);
        for (i = [0 : jar_thread_count() - 1]) {
            angle = i * 360 / jar_thread_count();
            rotate([0, 0, angle]) jar_lid_thread();
        }
    }
}

$fn = 100; // TODO remove me before commiting

//jar_lid_thread_profile();
//jar_lid_thread(s = "short");
//translate([100, 0, 0]) jar_lid_thread(s = "long");

jar_lid(bt = 0.5, od = jar_side_wall_outer_diameter() - 8, ribbed=false);
//jar_side_wall();

//        square(0.1);
//        translate([0, 0, jar_thread_width()]) square(0.1);
//        translate([jar_thread_height(), 0, 0]) square(0.1);
