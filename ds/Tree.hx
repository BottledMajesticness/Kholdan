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
        while (topLeaf.firstChild != null)
            this.topLeaf = node.firstChild;

        this.currentNode = topLeaf;
        this.isNewBranch = false;
    }

    public function next(): TreeNode<T> {
        if (this.isNewBranch) {
            while (currentNode.firstChild != null)
                currentNode = currentNode.firstChild;
        } else {
            if (this.currentNode.next != null) {
                this.currentNode = this.currentNode.next;
                this.isNewBranch = this.currentNode.firstChild != null;
            } else {
                this.currentNode = this.currentNode.parent;
                this.isNewBranch = false;
            }
        }

        return this.currentNode;
    }

    public function hasNext(): Bool {
        return this.currentNode != root;
    }
}