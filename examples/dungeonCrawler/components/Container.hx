package examples.dungeonCrawler.components;

class Container {
    public var maxWeight: Int;
    public var currentWeight: Int;
    public var items: Array<Item>;

    public function new(maxWeight: Int, ?items: Array<Item>) {
        this.maxWeight = maxWeight;

        if (items == null)
            this.items = new Array();
        else
            this.items = items;

        this.currentWeight = 0;

        for (item in this.items)
            this.currentWeight += item.weight;
    }

    public function add(item: Item): Void {
        items.push(item);
        this.currentWeight += item.weight;
    }

    public function remove(item: Item): Item {
        if (items.remove(item))
            currentWeight -= item.weight;
        return item;
    }

    public function consume(container: Container) {
        while (container.items.length > 0)
            this.add(container.items.pop());
        container.currentWeight = 0;
    }

    public function contents(): String {
        if (items.length == 0)
            return "Empty";
        
        items.sort((x: Item, y: Item) -> {
            if (x.name.charCodeAt(0) > y.name.charCodeAt(0))
                return 1;
            else if (x.name.charCodeAt(0) < y.name.charCodeAt(0))
                return -1;
            else
                return 0; 
        });

        var string: String = "";
        
        for (item in items)
            string += item.name + ", ";

        return string;
    }
}