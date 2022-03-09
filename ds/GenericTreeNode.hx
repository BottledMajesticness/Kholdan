package ds;

class GenericTreeNode<T> {
    public var data: T;

    public var parent: GenericTreeNode<T>;
    public var first_child: GenericTreeNode<T>;
    public var next: GenericTreeNode<T>;

    public function new(data: T) {
        this.data = data;
        this.first_child = null;
        this.next = null;
    }

    public inline function children(): Iterator<GenericTreeNode<T>> {
        return new ChildrenIterator<T>(this);
    }

    public inline function count(): Int {
        var i: Int = 0;
        for (child in this.children())
            i++;

        return i;
    }

    public function addChild(child: GenericTreeNode<T>): GenericTreeNode<T> {
        if (child.parent != null)
            throw "Node already is a child!";

        child.parent = this;
        child.next = this.first_child;

        this.first_child = child;
        return child;
    }

    public function insertChild(node: GenericTreeNode<T>, index: Int): GenericTreeNode<T> {
        if (node.parent != null)
            throw "Node already is a child!";

        index = toValidIndex(index);

        var i: Int = 0;
        var prev_child: GenericTreeNode<T> = this.first_child;

        for (child in this.children())
            if (i == index) {
                node.parent = this;
                node.next   = prev_child.next;

                prev_child.next = node;

                return node;
            } else {
                prev_child = child;
            }

        throw "Index Out Of Reach!";
    }

    public function removeFirstChild(): GenericTreeNode<T> {
        if (this.first_child == null)
            return null;

        var old: GenericTreeNode<T> = this.first_child;
        this.first_child = this.first_child.next;
        return old.orphan();
    }

    public function removeLastChild(): GenericTreeNode<T> {
        for (child in this.children())
            if (child.next == null)
                return child.orphan();
        return null;
    }

    public function removeChild(index: Int): GenericTreeNode<T> {
        index = toValidIndex(index);

        var i: Int = 0;
        var prevChild: GenericTreeNode<T> = this.first_child;

        for (child in this.children())
            if (i == index) {
                prevChild.next = child.next;
                return child.orphan();
            } else {
                prevChild = child;
            }

        throw "Index Out Of Reach!";
    }

    private inline function toValidIndex(index: Int): Int {
        if (index >= 0)
            return index;
        
        index = this.count() + index;

        if (index < 0)
            throw "cringe";

        return index;
    }

    private inline function orphan(): GenericTreeNode<T> {
        if (this != null) {
           this.parent = null;
           this.next = null;
        }

        return this;
    }
}

private class ChildrenIterator<T> {
    var current: GenericTreeNode<T>;

    public function new(node: GenericTreeNode<T>) {
        this.current = node.first_child;
    }

    public function next(): GenericTreeNode<T> {
        var last: GenericTreeNode<T> = this.current;
        this.current = this.current.next;
        return last;
    }

    public function hasNext(): Bool {
        return this.current != null;
    }
}