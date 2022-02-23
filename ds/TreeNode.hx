package ds;

class TreeNode<T> {
    public var data: T;

    public var parent: TreeNode<T>;
    public var firstChild: TreeNode<T>;
    public var next: TreeNode<T>;

    public function new(data: T) {
        this.data = data;
    }

    public inline function children(): Iterator<TreeNode<T>> {
        return new ChildrenIterator<T>(this);
    }

    public inline function count(): Int {
        var i: Int = 0;
        for (child in this.children())
            i++;

        return i;
    }

    public function addChild(child: TreeNode<T>): TreeNode<T> {
        if (child.parent != null)
            throw "Node already is a child!";

        child.parent = this;

        if (this.firstChild != null)
            child.next = this.firstChild;

        this.firstChild = child;
        return child;
    }

    public function insertChild(newChild: TreeNode<T>, index: Int): TreeNode<T> {
        if (newChild.parent != null)
            throw "Node already is a child!";

        index = toValidIndex(index);

        var i: Int = 0;
        var prevChild: TreeNode<T> = this.firstChild;

        for (child in this.children())
            if (i == index) {
                newChild.parent = this;
                newChild.next   = prevChild.next;

                prevChild.next = newChild;

                return newChild;
            } else {
                prevChild = child;
            }

        throw "Index Out Of Reach!";
    }

    public function removeFirstChild(): TreeNode<T> {
        if (this.firstChild == null)
            return null;

        var old: TreeNode<T> = this.firstChild;
        this.firstChild = this.firstChild.next;
        return old.orphan();
    }

    public function removeLastChild(): TreeNode<T> {
        for (child in this.children())
            if (child.next == null)
                return child.orphan();
        return null;
    }

    public function removeChild(index: Int): TreeNode<T> {
        index = toValidIndex(index);

        var i: Int = 0;
        var prevChild: TreeNode<T> = this.firstChild;

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

    private inline function orphan(): TreeNode<T> {
        if (this != null) {
           this.parent = null;
           this.next = null;
        }

        return this;
    }
}

private class ChildrenIterator<T> {
    var currentNode: TreeNode<T>;

    public function new(node: TreeNode<T>) {
        this.currentNode = node.firstChild;
    }

    public function next(): TreeNode<T> {
        this.currentNode = this.currentNode.next;
        return this.currentNode;
    }

    public function hasNext(): Bool {
        return this.currentNode.next == null;
    }
}