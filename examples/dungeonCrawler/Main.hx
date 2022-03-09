package examples.dungeonCrawler;

import ecs.ComponentManager;
import ecs.Entity;
import ds.Grid;

import examples.dungeonCrawler.components.*;

using examples.dungeonCrawler.Prefabs;
using ecs.ComponentExtender;

class Main {
    static var player: Entity;
    static var ecs: ComponentManager;
    static var rooms: Grid<Array<Entity>>;

    static public function main() {
        ecs = new ComponentManager();

        var container: Container = ecs.container(3).getComponent(Container);
        Sys.println(ecs.getEntitiesIdsWith(Container).next());

        while (container.currentWeight < container.maxWeight) {
            container.add(ecs.garbageItem("Boot").getComponent(Item));
        }

        Sys.println(container.contents());
        for (item in ecs.getEntitiesIdsWith(Item))
            Sys.println(item);

        container.remove(container.items[0]).getEntity(ecs).destroy();

        Sys.println(container.contents());
        for (item in ecs.getEntitiesIdsWith(Item))
            Sys.println(item);

        container.add(ecs.garbageItem("Boot").getComponent(Item));
        container.add(ecs.garbageItem("Boot").getComponent(Item));

        Sys.println(container.contents());
        for (item in ecs.getEntitiesIdsWith(Item))
            Sys.println(item);
    }
}