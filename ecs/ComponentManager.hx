package ecs;

class ComponentManager {
    // Holds all of the "entity->component" maps in a map
    private var metaMap: Map<String, Map<String, Any>>;

    public function new() {
        this.metaMap = new Map();
    }

    // Allows access to a "entity->component" map of components T
    public inline function getComponents<T>(componentClass: Class<T>): Map<String, T> {
        // Probably could rewrite this as a try/catch block
        var className = Type.getClassName(componentClass);
        if (metaMap.exists(className))
            return cast metaMap[className];

        // Disgusting casting, might be unsafe, might be not. Yeah, I'm not really good at this?
        throw 'No components of $className have been created!';
    }
    
    // Creates an entity->component of type T in a corresponding map
    // If such map does not exist, this method creates one
    public function addToEntity<T>(entityId: String, component: T): Void {
        var inputClass = Type.getClass(component);
        var className  = Type.getClassName(inputClass);

        if (!metaMap.exists(className))
            metaMap.set(className, new Map<String, T>());

        getComponents(inputClass).set(entityId, component);
    }

    public function removeEntity(entityId: String) {
        for (map in this.metaMap)
            map.remove(entityId);
    }

    public function removeComponents<T>(componentClass: Class<T>) {
        getComponents(componentClass).clear();
        metaMap.remove(Type.getClassName(componentClass));
    }
}