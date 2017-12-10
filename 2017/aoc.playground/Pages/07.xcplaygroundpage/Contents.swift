//: [Previous](@previous)

import Foundation

let fileURL = Bundle.main.url(forResource: "input", withExtension: "txt")
let content = try String(contentsOf: fileURL!, encoding: String.Encoding.utf8)
let input = content.split(separator: "\n").map { $0.split(separator: " ") }

var items = [String: P]()

for i in input {
    let name = String(i[0])
    let children: [String] = i.count > 2 ? i[3...].map { String($0.split(separator: ",").first!) } : []
    items[name] = P(
        name: name,
        number: Int(i[1].filter{ Int("\($0)") != nil })!,
        childStrings: children)
}


let root = findRoot(items: items)
print("Part 1 is", root)

let tree = createTree(i: items)
print("Part2 is ", findImbalance(tree)!)

//: [Next](@next)
