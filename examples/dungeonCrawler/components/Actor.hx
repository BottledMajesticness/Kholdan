package examples.dungeonCrawler.components;

class Actor {
    public var name: String;
    public var stats: Stats;
    public var health: Int;
    public var damage: Int;

    public function new(name: String, level: Int) {
        this.name = name;
        this.stats = Stats.random(level);
        this.damage = if (this.stats.str_mod > 0) this.stats.str_mod else 1;
        this.health = 10 + this.stats.con_mod;
    }
}

class Stats {
    public var str: Int;
    public var con: Int;

    public var str_mod: Int;
    public var con_mod: Int;

    public function new(str: Int, con: Int) {
        this.str = str;
        this.con = con;
        this.str_mod = Std.int(str / 2) - 5;
        this.con_mod = Std.int(con / 2) - 5;
    }

    public static function random(level: Int): Stats {
        var proportion: Float = Math.random();

        inline function random_stat_val(level_dist): Int {
            return 10 + Std.int((Math.random() - 0.5) * 10 + level * proportion);
        }
        return new Stats(random_stat_val(proportion), random_stat_val(1 - proportion));
    }
}