package ds;

class Tree<T> {
    public var root(default, null): TreeNode<T>;

    public function new(root: T) {
        this.root = new TreeNode<T>(root);
    }

    public inline function iterator(): Iterator<TreeNode<T>> {
        return new TreeIterator<T>(this.root);
    }
}

private class TreeIterator<T> {
    var root: TreeNode<T>;
    var current: TreeNode<T>;
    var start: TreeNode<T>;

    public function new(node: TreeNode<T>) {
        this.root = node;
        this.start = node;
        while (true) {
            if (this.start.first_child == null)
                break;
            this.start = this.start.first_child;
        }  

        this.current = start;
    }

    public function next(): TreeNode<T> {
        var old = this.current;

        if (this.current.next == null) {
            this.current = this.current.parent;
        } else {
            this.current = this.current.next;
            while (this.current.first_child != null)
                this.current = this.current.first_child;
        }

        return old;
    }

    public function hasNext(): Bool {
        return this.current != root;
    }
}