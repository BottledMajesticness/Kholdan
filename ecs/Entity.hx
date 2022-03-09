package ecs;

import ds.TreeNode;

class Entity extends TreeNode {
    public var id: Int;
    public var name: String;

    public function new(name: String, id: Int) {
        super();
        this.name = name;
        this.id = id;
    }
}