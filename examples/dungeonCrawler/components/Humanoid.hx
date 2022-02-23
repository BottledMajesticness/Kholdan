package examples.dungeonCrawler.components;

import ecs.Entity;

// Any entity that can carry equipment and has an inventory
class Humanoid {
    var weapon: Weapon;
    public var inventory: Array<Entity>;

    public function new() {
        this.weapon = null;
        this.inventory = new Array();
    }
}