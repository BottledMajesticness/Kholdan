package examples.treeExample;

import ds.TreeNode;
import ds.Tree;

class Main {
    static var tree: Tree<String>;

    static function main() {

        tree = new Tree("Root");
        var layer1: TreeNode<String> = tree.root.addChild(new TreeNode("1"));
        layer1.addChild(new TreeNode("1:1"));
        layer1.addChild(new TreeNode("1:2"));

        var layer2 = tree.root.addChild(new TreeNode("2"));
        layer2.addChild(new TreeNode("2:1"));
        layer2.addChild(new TreeNode("2:2"));

        var layer3 = tree.root.addChild(new TreeNode("3"));
        layer3.addChild(new TreeNode("3:1"));
        layer3.addChild(new TreeNode("3:2"));

        var sublayer = layer2.firstChild.next.addChild(new TreeNode("2:1:1"));
        sublayer.addChild(new TreeNode("2:1:1:1"));
        sublayer.addChild(new TreeNode("2:1:1:2"));

        // Sys.println(layer3.firstChild == null);
        // Sys.println(layer3.firstChild.firstChild == null);

        // while (true) {
        //     Sys.println(tree.iterator().next().data);
        //     Sys.stdin().readLine();
        
        // for (child in layer1.children()) {
        //     Sys.println(child.data);
        // }

        // for (child in layer2.children()) {
        //     Sys.println(child.data);
        // }

        // for (child in layer3.children()) {
        //     Sys.println(child.data);
        // }

        for (obj in tree) {
            Sys.println(obj.data);
            Sys.stdin().readLine();
        }
    }


}