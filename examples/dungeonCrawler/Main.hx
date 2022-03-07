package examples.dungeonCrawler;

import ecs.ComponentManager;
import ecs.Entity;
import ds.Grid;

import examples.dungeonCrawler.components.*;

using examples.dungeonCrawler.Prefabs;

class Main {
    static var player: Entity;
    static var ecs: ComponentManager;
    static var rooms: Grid<Array<Entity>>;

    static public function main() {
        ecs = new ComponentManager();
        var container: Container = ecs.container(3).getComponent(Container);
        Sys.println(ecs.getComponents(Container).keys().next());

        while (container.currentWeight < container.maxWeight) {
            container.add(ecs.garbageItem("Boot").getComponent(Item));
        }

        Sys.println(container.contents());
        for (item in ecs.getComponents(Item).keys())
            Sys.println(item);

        Entity.entityMap[ecs.getEnitity(container.remove(container.items[0]))].destroy();

        Sys.println(container.contents());
        for (item in ecs.getComponents(Item).keys())
            Sys.println(item);

        container.add(ecs.garbageItem("Boot").getComponent(Item));
        container.add(ecs.garbageItem("Boot").getComponent(Item));

        Sys.println(container.contents());
        for (item in ecs.getComponents(Item).keys())
            Sys.println(item);
    }
}