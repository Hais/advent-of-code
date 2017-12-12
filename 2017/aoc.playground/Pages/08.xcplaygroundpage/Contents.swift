//: [Previous](@previous)

import Foundation


let fileURL = Bundle.main.url(forResource: "input", withExtension: "txt")
let content = try String(contentsOf: fileURL!, encoding: String.Encoding.utf8)
let input = content.split(separator: "\n").map { $0.split(separator: " ").map(String.init) }

let compFns: [String: ((Int, Int) -> Bool)] = [
    "<": { $0 < $1 },
    ">": { $0 > $1 },
    "<=": { $0 <= $1 },
    ">=": { $0 >= $1 },
    "!=": { $0 != $1 },
    "==": { $0 == $1 }
]

let modFns: [String: (Int, Int) -> Int] = [
    "inc": { $0 + $1 },
    "dec": { $0 - $1 },
]

typealias Mod = (name: String, fn: ((Int, Int) -> Int), val: Int)
typealias Cond = (name: String, fn: ((Int, Int) -> Bool), val: Int)
typealias Instruction = (modifier: Mod, condition: Cond)

let makeInstruction: ([String]) -> Instruction = {(
    modifier: (name: $0[0], fn: modFns[$0[1]]!, val: Int($0[2])!),
    condition: (name: $0[4], fn: compFns[$0[5]]!, val: Int($0[6])!)
)}

var highest = 0
let trackHighest: (Int) -> Int = { highest = max(highest, $0); return $0 }

let output =
    input
    .map(makeInstruction)
    .reduce(into: [String: Int]()) { d, i in
        let (m, c) = i
        guard c.fn(d[c.name] ?? 0, c.val) else { return }
        d[m.name] = trackHighest(m.fn(d[m.name] ?? 0, m.val))
    }

print("Part 1 is", output.values.sorted().last!)
print("Part 2 is", highest)

//: [Next](@next)
