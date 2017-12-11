import Foundation

public class P {
    var name: String = ""
    var number: Int = 0
    var c: [String] = []
    var child: [P] = []
    public init(name: String, number: Int, childStrings: [String]) {
        self.name = name
        self.number = number
        self.c = childStrings
    }
}


public func findRoot(items i: [String: P]) -> String {
    // subtract all children nodes the node list, the remaining one is the root node
    let children = i.values.reduce([]) { $0 + $1.c }
    return Set(i.keys).subtracting(children).first!
}

func createTree(fromRoot prog: P, with items: [String: P]) -> P {
    prog.child = prog.c.map { createTree(fromRoot: items[$0]!, with: items) }
    return prog
}

public func createTree(i: [String: P]) -> P {
    return createTree(fromRoot: i[findRoot(items: i)]!, with: i)
}


func weigh(_ p: P) -> Int {
    return p.child.map(weigh).reduce(p.number, +)
}


public func findImbalance(_ p: P) -> Int? {
    if p.child.isEmpty {
        return nil
    }
    
    let weights = p.child.map(weigh)
    let sortedWeights = weights.sorted()
    
    if weights.count == 0 || (sortedWeights.first! == sortedWeights.last!) {
        return nil
    }
    
    let difference = sortedWeights.last! - sortedWeights.first!
    let unbalanced = zip(weights, p.child).first{ $0.0 == sortedWeights.last! }!
    return findImbalance(unbalanced.1) ?? unbalanced.1.number - difference
}



