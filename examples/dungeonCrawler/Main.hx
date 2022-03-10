package examples.dungeonCrawler;

import ecs.ComponentManager;
import ecs.Entity;
import ds.Grid;

import examples.dungeonCrawler.Prefabs;
import examples.dungeonCrawler.components.*;

using ecs.ECSUtils;

class Main {
    static var player: Entity;
    static var rooms: Grid<Array<Entity>>;

    static public function main() {
        ECSUtils.world = new ComponentManager();

        var container: Container = Prefabs.container(3).getComponent(Container);
        Sys.println(Container.entities().next());

        while (container.currentWeight < container.maxWeight) {
            container.add(Prefabs.garbageItem("Boot").getComponent(Item));
        }

        Sys.println(container.contents());
        for (id in Item.entities())
            Sys.println(id);

        container.remove(container.items[0]).getEntity().free();

        Sys.println(container.contents());
        for (id in Item.entities())
            Sys.println(id);

        container.add(Prefabs.garbageItem("Boot").getComponent(Item));
        container.add(Prefabs.garbageItem("Boot").getComponent(Item));

        Sys.println(container.contents());
        for (id in Item.entities())
            Sys.println(id);
    }
}