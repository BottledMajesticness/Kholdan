package ecs;

import haxe.ds.GenericStack;

class Entity {
    var componentManager: ComponentManager;
    static var id_counter: Int = 0;
    public static var entityMap: Map<Int, Entity> = new Map();
    static var free_ids: GenericStack<Int> = new GenericStack();
    public var id: Int;
    public var name: String;

    public function new(name: String, componentManager: ComponentManager) {
        if (free_ids.isEmpty()) {
            this.id = id_counter;
            id_counter++;
        } else {
            this.id = free_ids.pop();
        }

        entityMap.set(this.id, this);

        this.componentManager = componentManager;
    }

    public function destroy() {
        this.componentManager.removeEntity(this.id);
        entityMap.remove(this.id);
        free_ids.add(this.id);

        this.id = null;
        this.componentManager = null;
    } 

    public inline function addComponent<T>(component: T): Void {
        componentManager.addToEntity(this.id, component);
    }

    public inline function removeComponent<T>(componentClass: Class<T>): Void {
        componentManager.getComponents(componentClass).remove(this.id);
    }

    public inline function getComponent<T>(componentClass: Class<T>): T {
        return componentManager.getComponents(componentClass)[this.id];
    }

    public inline function hasComponent<T>(componentClass: Class<T>): Bool {
        return componentManager.getComponents(componentClass).exists(this.id);
    }
}