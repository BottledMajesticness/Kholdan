package ecs;

class Entity {
    var componentManager: ComponentManager;
    public var id: String;

    public function new(id: String, componentManager: ComponentManager) {
        this.id = id;
        this.componentManager = componentManager;
    }

    public function destroy() {
        this.componentManager.removeEntity(this.id);

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