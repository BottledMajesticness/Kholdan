package ecs;

class SystemManager {
    var event_map: Map<EnumValue, List<()->EnumValue>>;

    function new() {
        event_map = new Map();
    }

    function runSystems(event: EnumValue): Void {
        for (system in event_map[event])
            runSystems(system());
    }

    function remove(event: EnumValue, system: List<()->EnumValue>): Void {
        event_map[event].remove(system);
    }

    function () {
        
    }
}