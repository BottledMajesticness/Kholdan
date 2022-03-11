package ecs;

import haxe.Constraints.Function;

class SystemManager {
    var event_map: Map<EnumValue, Array<()->EnumValue>>;

    function runSystems(event: EnumValue) {
        for (system in event_map[event])
            runSystems(system());
    }
}