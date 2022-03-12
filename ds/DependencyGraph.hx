package ds;

import haxe.ds.GenericStack;

class DependencyGraph<T> {
    var graph: List<GenericStack<T>>;

    function new() {
        this.graph = new List();
        this.graph.add(new GenericStack());
    }

    public function iterator(): DependencyGraphIterator<T> {
        return new DependencyGraphIterator<T>(graph);
    }

    function add<DS: Iterable<T>>(object: T, ?dependencies: DS) {
        function check_dependencies(stack: GenericStack<T>): Bool {
            for (item in stack)
                for (dependency in dependencies)
                    if (item == dependency)
                        return true;

            return false;
        }

        if (dependencies == null)
            return graph.first().add(object);

        var target_dependency_layer: GenericStack<T>;
        var iterator = this.graph.iterator();
        var flag: Bool = false;

        for (dependency_layer in iterator) {
            if (flag)
                target_dependency_layer = dependency_layer;

            if (iterator.hasNext()) {
                flag = check_dependencies(dependency_layer);
            } else if (check_dependencies(dependency_layer)) {
                this.graph.add(new GenericStack<T>());
                target_dependency_layer = graph.last();
            }
        }

        if (target_dependency_layer == null)
            throw "Invalid dependencies!";
        else
            target_dependency_layer.add(object);
    }
}

private class DependencyGraphIterator<T> {
    var current: T;
    var graph: Iterator<GenericStack<T>>;
    var stack: Iterator<T>;

    public function new(graph: List<GenericStack<T>>) {
        this.graph = graph.iterator();
        this.stack = this.graph.next().iterator();
        this.current = this.stack.next();
    }

    public function next() {
        var old = this.current;

        if (this.stack.hasNext())
            this.current = this.stack.next();
        else {
            this.stack = this.graph.next().iterator();
            this.current = this.stack.next();
        }

        return old;
    }

    public function hasNext() {
        return this.stack.hasNext() || this.stack.hasNext();
    }
}