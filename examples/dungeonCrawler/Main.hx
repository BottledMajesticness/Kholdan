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
        player = new Entity("Player", ecs);
        var container: Container = ecs.container(20).getComponent(Container);

        while (container.currentWeight < container.maxWeight) {
            container.add(ecs.garbageItem("Boot").getComponent(Item));
        }

        Sys.println(Type.getSuperClass(Container));
    }
}