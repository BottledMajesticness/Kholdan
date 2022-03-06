package examples.dungeonCrawler.components;

class Item {
    public var weight: Int;
    public var name: String;

    public function new(name: String, weight: Int) {
        this.weight = weight;
        this.name = name;
    }
}