use <../common/circle_sector.scad>
use <breadwinner.scad>

function breadwinner_snapring_inner_diameter() = breadwinner_center_sensor_hole_diameter();
function breadwinner_snapring_outer_diameter() = breadwinner_snapring_inner_diameter() + 1.0;
function breadwinner_snapring_rim_diameter() = breadwinner_snapring_outer_diameter() + 3.0;
function breadwinner_snapring_rim_thickness() = breadwinner_socket_baseplate_thickness() / 2;
function breadwinner_snapring_height() = 2.0;
function breadwinner_snapring_hook_overhang() = 0.1;
function breadwinner_snapring_number_of_cutouts() = 16;
function breadwinner_snapring_cutout_radius() = 5;

module breadwinner_snapring_cutout(
    od = breadwinner_snapring_outer_diameter(),
    h = breadwinner_snapring_height(),
    noc = breadwinner_snapring_number_of_cutouts(),
    cr = breadwinner_snapring_cutout_radius()
) {
    linear_extrude(height = h) {
        for(rotate_degrees = [0 : 360 / noc : 360 - 360 / noc])
            rotate([0, 0, rotate_degrees])
                circle_sector(r = od, a = [0, cr]);
    }
}

// Warning: need at least $fn = 10 for the snapring to even be visible. $fn = 100 or higher recommended.
module breadwinner_snapring(
    id = breadwinner_snapring_inner_diameter(),
    od = breadwinner_snapring_outer_diameter(),
    rd = breadwinner_snapring_rim_diameter(),
    t = breadwinner_snapring_rim_thickness(),
    h = breadwinner_snapring_height(),
    ho = breadwinner_snapring_hook_overhang()
) {
    w = (od - id) / 2;
    rim_offset_x = od / 2;
    rim_offset_y = 0;
    rim_w = (rd - od) / 2;

    ring_offset_x = id / 2;

    hook_d = w + ho;
    round_tip_offset_x = ring_offset_x;
    round_tip_offset_y = h;

    cutout_h = h + hook_d;
    cutout_translate = [0, 0, t];

    difference() {
        rotate_extrude() {
            union() {
                translate([rim_offset_x, rim_offset_y]) square([rim_w, t], center = false);
                translate([ring_offset_x, 0]) square([w, h], center = false);
                translate([round_tip_offset_x, round_tip_offset_y]) circle_sector(r = hook_d, a = [0, 90]);
            }
        }
        translate(cutout_translate) breadwinner_snapring_cutout(h = cutout_h);
    }
}

breadwinner_snapring();