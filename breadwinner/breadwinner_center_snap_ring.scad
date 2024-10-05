use <../common/circle_sector.scad>
use <breadwinner.scad>

function breadwinner_center_snap_ring_outer_diameter() = breadwinner_center_sensor_hole_diameter();
function breadwinner_center_snap_ring_inner_diameter() = breadwinner_center_snap_ring_outer_diameter() - 1.0;

function breadwinner_center_snap_ring_rim_diameter() = breadwinner_center_snap_ring_outer_diameter() + 3.0;
function breadwinner_center_snap_ring_rim_thickness() = breadwinner_socket_baseplate_thickness() / 2;
function breadwinner_center_snap_ring_height() = 2.0;
function breadwinner_center_snap_ring_hook_overhang() = 0.1;
function breadwinner_center_snap_ring_number_of_cutouts() = 16;
function breadwinner_center_snap_ring_cutout_radius() = 5;

module breadwinner_center_snap_ring_hooks(
    id = breadwinner_center_snap_ring_inner_diameter(),
    od = breadwinner_center_snap_ring_outer_diameter(),
    h = breadwinner_center_snap_ring_height(),
    ho = breadwinner_center_snap_ring_hook_overhang(),
    noc = breadwinner_center_snap_ring_number_of_cutouts(),
    cr = breadwinner_center_snap_ring_cutout_radius()
) {
    w = (od - id) / 2;
    ring_offset_x = id / 2;

    hook_d = w + ho;

    round_tip_offset_x = ring_offset_x;
    round_tip_offset_y = h;

    extrude_radius = 360 / noc - cr;
    for(rotate_degrees = [0 : 360 / noc : 360 - 360 / noc])
    rotate([0, 0, rotate_degrees])
        rotate([0, 0, 90])
            rotate_extrude(angle = extrude_radius)

            union() {
            translate([ring_offset_x, 0]) square([w, h], center = false);
            translate([round_tip_offset_x, round_tip_offset_y]) circle_sector(r = hook_d, a = [0, 90]);
        }
}

module breadwinner_center_snap_ring(
    id = breadwinner_center_snap_ring_inner_diameter(),
    od = breadwinner_center_snap_ring_outer_diameter(),
    rd = breadwinner_center_snap_ring_rim_diameter(),
    t = breadwinner_center_snap_ring_rim_thickness(),
    h = breadwinner_center_snap_ring_height(),
    ho = breadwinner_center_snap_ring_hook_overhang()
) {
    w = (od - id) / 2;
    rim_offset_x = id / 2;
    rim_offset_y = 0;
    rim_w = (rd - od) / 2;

    ring_offset_x = id / 2;

    hook_d = w + ho;
    round_tip_offset_x = ring_offset_x;
    round_tip_offset_y = h;

    cutout_h = h + hook_d;
    cutout_translate = [0, 0, t + 0.1];

    union() {
        rotate_extrude() {
            translate([rim_offset_x, rim_offset_y]) square([rim_w, t], center = false);
        }
        breadwinner_center_snap_ring_hooks(id = id, od = od, h = h, ho = ho);
    }
}

breadwinner_center_snap_ring();
