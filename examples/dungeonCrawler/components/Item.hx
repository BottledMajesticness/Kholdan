package examples.dungeonCrawler.components;

class Item {
    public var name: String;
    var weight: Int;

    public function new(name: String, weight: Int) {
        this.name = name;
        this.weight = weight;
    }
}