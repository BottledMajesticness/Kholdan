package examples.dungeonCrawler;

import ecs.ComponentManager;
import ecs.Entity;

import examples.dungeonCrawler.components.*;

class Main {
    static var player: Entity;
    static var componentManager: ComponentManager;

    static public function Main() {
        player = new Entity("Player", componentManager);
        player.addComponent(new Actor("Player", 50));
        player.addComponent(new Humanoid());
    }

    static function playerSystem() {
        var prompt: PlayerPrompt;

        switch (prompt) {
            case Inventory:
                checkInventory();
            case Inspect(s):
                Sys.println(s.getComponent(Visible).displayText);
            case Open(s):
                listOutItems(s.getComponent(Container).items);
            case Take(s):
                return;
            case Drop(s):
                return;
            case Equip(s):
                return;
            case Unequip(s):
                return;
            case Attack(s):
                return;
            case Move(s):
                return;
        }
    }

    static function checkInventory() {
        listOutItems(player.getComponent(Humanoid).inventory);
    }

    static function listOutItems(items: Array<Entity>) {
        for (item in items)
            Sys.println(item.getComponent(Item).name);
    }
}



enum PlayerPrompt {
    Inventory;
    Inspect(entity: Entity);
    Open(entity: Entity);
    Take(entity: Entity);
    Drop(entity: Entity);
    Equip(entity: Entity);
    Unequip(entity: Entity);
    Attack(entity: Entity);
    Move(direction: String);
}