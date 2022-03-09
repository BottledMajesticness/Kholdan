package ecs;

class Entity {
    public var id: Int;
    public var name: String;

    public function new(name: String, id: Int) {
        this.name = name;
        this.id = id;
    }
}