use <../../breadwinner/breadwinner.scad>
use <../../jars/jar-77mm.scad>

// Supports are needed for the jar lid to be printed correctly. The surface will still not be
// perfect, but it will be a single piece adapter. Other option is to print Breadwinner and jar
// lid separately and then glue them together.
union() {
    rotate([180, 0, 0]) jar_lid(bt = 0.5);
    breadwinner_socket(bt = 0.5);
}
