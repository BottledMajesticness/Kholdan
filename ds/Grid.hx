package ds;

import haxe.ds.Vector;

class Grid<T> {
    public var cells: Vector<T>;
    public var width(default, null): Int;
    public var height(default, null): Int;

    public function new(width, height) {
        this.width = width;
        this.height = height;
        this.cells = new Vector<T>(width * height);
    }

    public inline function get_cell(x: Int, y: Int): T {
        if (x < width && y < height)
            return this.cells[y * width + x];
        throw '($x, $y) is out of range';
    }

    public inline function set_cell(x: Int, y: Int, value: T): Void {
        if (x < width && y < height)
            this.cells[y * width + x] = value;
        throw '($x, $y) is out of range';
    }
}