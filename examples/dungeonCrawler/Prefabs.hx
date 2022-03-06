package examples.dungeonCrawler;

import examples.dungeonCrawler.components.Container;
import examples.dungeonCrawler.components.Item;
import ecs.ComponentManager;
import ecs.Entity;

class Prefabs {
    public static inline function garbageItem(ecs: ComponentManager, name: String, weight: Int = 1): Entity {
        var garbage: Entity = new Entity(name, ecs);
        garbage.addComponent(new Item(name, weight));
        return garbage;
    }

    public static inline function container(ecs: ComponentManager, maxWeight: Int = 1): Entity {
        var container: Entity = new Entity("container", ecs);
        container.addComponent(new Container(maxWeight));
        return container;
    }
}