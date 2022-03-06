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
    var currentNode: TreeNode<T>;
    var topLeaf: TreeNode<T>;
    var isNewBranch: Bool;

    public function new(node: TreeNode<T>) {
        this.root = node;
        this.topLeaf = node;
        while (true) {
            if (this.topLeaf.firstChild == null)
                break;
            this.topLeaf = this.topLeaf.firstChild;
        }  

        this.currentNode = topLeaf;
        this.isNewBranch = false;
    }

    public function next(): TreeNode<T> {
        var old = this.currentNode;

        if (this.currentNode.next == null) {
            this.currentNode = this.currentNode.parent;
        } else {
            this.currentNode = this.currentNode.next;
            while (this.currentNode.firstChild != null)
                this.currentNode = this.currentNode.firstChild;
        }

        return old;
    }

    public function hasNext(): Bool {
        return this.currentNode != root;
    }
}