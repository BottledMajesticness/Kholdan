package ecs;

import haxe.ds.GenericStack;

class ECSUtils {
    static var id_counter: Int = 0;
    static var free_ids: GenericStack<Int> = new GenericStack();

    public static var world: ComponentManager;
    public static var entity_map: Map<Int, Entity> = new Map();

    // entity instancing utils
    @:noUsing
    public static inline function createEntity(name: String): Entity {
        inline function generate_id(): Int {
            if (free_ids.isEmpty())
                return id_counter++;
            else
                return free_ids.pop();
        }

        var entity = new Entity(name, generate_id());
        entity_map.set(entity.id, entity);
        return entity;
    }

    public static inline function destroy(enitity: Entity) {
        entity_map.remove(enitity.id);
        free_ids.add(enitity.id);

        for (map in world.meta_map)
            map.remove(enitity.id);

        enitity.id = null;
    }

    // managing components in entities
    public static inline function addComponent<T>(entity: Entity, component: T): Void {
        world.addToEntity(entity.id, component);
    }

    public static inline function removeComponent<T>(entity: Entity, componentClass: Class<T>): Void {
        world.getECMapOf(componentClass).remove(entity.id);
    }

    public static inline function getComponent<T>(entity: Entity, componentClass: Class<T>): T {
        return world.getECMapOf(componentClass)[entity.id];
    }

    public static inline function hasComponent<T>(entity: Entity, componentClass: Class<T>): Bool {
        return world.getECMapOf(componentClass).exists(entity.id);
    }

    // access to entity from a component
    public static inline function getEntity<T>(component: T): Entity {
        for (id => comp in world.getECMapOf(Type.getClass(component)))
            if (comp == component)
                return entity_map[id];
        
        throw 'No entity with $component';
    }

    // access to global lists
    public static inline function instances<T>(component_class: Class<T>): Iterator<T> {
        return world.getECMapOf(component_class).iterator();
    }

    public static inline function entities<T>(component_class: Class<T>): Iterator<Int> {
        return world.getECMapOf(component_class).keys();
    }
}