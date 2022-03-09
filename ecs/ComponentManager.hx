package ecs;

class ComponentManager {
    // Holds all of the "entity -> component" maps in a map
    public var meta_map: Map<String, Map<Int, Any>>;

    public function new() {
        this.meta_map = new Map();
    }


    // Allows access to a "entity -> component" map of components T
    public inline function getECMapOf<T>(component_class: Class<T>): Map<Int, T> {
        // Probably could rewrite this as a try/catch block
        var class_name = Type.getClassName(component_class);
        if (meta_map.exists(class_name))
            return cast meta_map[class_name];

        // Disgusting casting, might be unsafe, might be not. Yeah, I'm not really good at this?
        throw 'No components of $class_name have been created!';
    }
    
    // Creates an entity->component of type T in a corresponding map
    // If such map does not exist, this method creates one
    public function addToEntity<T>(id: Int, component: T): Void {
        var input_class = Type.getClass(component);
        var class_name  = Type.getClassName(input_class);

        if (!meta_map.exists(class_name))
            meta_map.set(class_name, new Map<Int, T>());

        getECMapOf(input_class).set(id, component);
    }

    public function removeEntity(id: Int) {
        
    }

    public function removeComponents<T>(component_class: Class<T>) {
        getECMapOf(component_class).clear();
        meta_map.remove(Type.getClassName(component_class));
    }
}

typedef EntityId = Int;