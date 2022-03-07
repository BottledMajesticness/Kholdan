package ecs;

class ComponentManager {
    // Holds all of the "entity->component" maps in a map
    private var metaMap: Map<String, Map<Int, Any>>;

    public function new() {
        this.metaMap = new Map();
    }

    // Allows access to a "entity->component" map of components T
    public inline function getComponents<T>(componentClass: Class<T>): Map<Int, T> {
        // Probably could rewrite this as a try/catch block
        var className = Type.getClassName(componentClass);
        if (metaMap.exists(className))
            return cast metaMap[className];

        // Disgusting casting, might be unsafe, might be not. Yeah, I'm not really good at this?
        throw 'No components of $className have been created!';
    }

    public function getEnitity<T>(component: T): Int {
        for (entity => comp in metaMap[Type.getClassName(Type.getClass(component))].keyValueIterator())
            if (comp == component)
                return entity;

        throw 'No entity with such component';
    }
    
    // Creates an entity->component of type T in a corresponding map
    // If such map does not exist, this method creates one
    public function addToEntity<T>(entityId: Int, component: T): Void {
        var inputClass = Type.getClass(component);
        var className  = Type.getClassName(inputClass);

        if (!metaMap.exists(className))
            metaMap.set(className, new Map<Int, T>());

        getComponents(inputClass).set(entityId, component);
    }

    public function removeEntity(entityId: Int) {
        for (map in this.metaMap)
            map.remove(entityId);
    }

    public function removeComponents<T>(componentClass: Class<T>) {
        getComponents(componentClass).clear();
        metaMap.remove(Type.getClassName(componentClass));
    }
}