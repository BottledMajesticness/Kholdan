package examples.dungeonCrawler;

import examples.dungeonCrawler.components.Actor;
import examples.dungeonCrawler.components.Container;
import examples.dungeonCrawler.components.Item;
import ecs.Entity;

using ecs.ECSUtils;

class Prefabs {
    public static inline function garbageItem(name: String, weight: Int = 1): Entity {
        var garbage: Entity = ECSUtils.createEntity(name);
        garbage.addComponent(new Item(name, weight));
        return garbage;
    }

    public static inline function container(maxWeight: Int = 1): Entity {
        var container: Entity = ECSUtils.createEntity("Container");
        container.addComponent(new Container(maxWeight));
        return container;
    }

    public static inline function NPC(name: String, level: Int): Entity {
        var npc: Entity = ECSUtils.createEntity(name);
        npc.addComponent(new Actor(name, level));
        return npc;
    }
}