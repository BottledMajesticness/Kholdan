package examples.dungeonCrawler.components;

class Actor {
    public var name: String;
    public var health: Int;
    
    public function new(name: String, health: Int) {
        this.name = name;
        this.health = health;
    }
}