package ecs;

class ComponentExtender<T> {
    public static inline function getEntity<T>(component: T, ecs: ComponentManager): Entity {
        return ecs.getOwnerOf(component);
    }
}