package ecs;

class ComponentManager {
    // Holds all of the "entity -> component" maps in a map
    private var metaMap: Map<String, Map<EntityId, Any>>;


    public function new() {
        this.metaMap = new Map();
    }


    // Allows access to a "entity -> component" map of components T
    public inline function getECMapOf<T>(componentClass: Class<T>): Map<EntityId, T> {
        // Probably could rewrite this as a try/catch block
        var className = Type.getClassName(componentClass);
        if (metaMap.exists(className))
            return cast metaMap[className];

        // Disgusting casting, might be unsafe, might be not. Yeah, I'm not really good at this?
        throw 'No components of $className have been created!';
    }


    // Nice iterator access functions
    public inline function getComponents<T>(componentClass: Class<T>): Iterator<T> {
        return getECMapOf(componentClass).iterator();
    }

    public inline function getEntitiesIdsWith<T>(componentClass: Class<T>): Iterator<Int> {
        return getECMapOf(componentClass).keys();
    }


    // Returns an entity that possess said component (probably needs a rework)
    public function getOwnerOf<T>(component: T): Entity {
        for (entity => comp in getECMapOf(Type.getClass(component)))
            if (comp == component)
                return Entity.entityMap[entity];

        throw 'No entity with such component';
    }

    
    // Creates an entity->component of type T in a corresponding map
    // If such map does not exist, this method creates one
    public function addToEntity<T>(id: EntityId, component: T): Void {
        var inputClass = Type.getClass(component);
        var className  = Type.getClassName(inputClass);

        if (!metaMap.exists(className))
            metaMap.set(className, new Map<EntityId, T>());

        getECMapOf(inputClass).set(id, component);
    }

    public function removeEntity(id: EntityId) {
        for (map in this.metaMap)
            map.remove(id);
    }

    public function removeComponents<T>(componentClass: Class<T>) {
        getECMapOf(componentClass).clear();
        metaMap.remove(Type.getClassName(componentClass));
    }
}

typedef EntityId = Int;