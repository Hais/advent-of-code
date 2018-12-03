//: [Previous](@previous)

import Foundation
import XCTest


let input: [String] = try!
    String(
        contentsOf: Bundle.main.url(forResource: "input", withExtension: "txt")!,
        encoding: .utf8
        )
        .components(separatedBy: .newlines)


let p1: ([String], [Int]) -> Int = { input, idx in
    let counts = input.map {
        Dictionary(grouping: $0.map(String.init)) { $0 }.mapValues { $0.count }.values.map { $0 }
    }.reduce(into: Dictionary<Int, Int>()) { dict, vals in
            Set<Int>(vals).forEach { num in
                dict[num] = (dict[num] ?? 0) + 1
            }
    }
    return idx.compactMap { counts[$0] }.reduce(0, *)
}


let p2: ([String]) -> String = { input in
    for (i, left) in input.enumerated() {
        for right in input[i...] {
            let diff = zip(left, right)
                .compactMap { $0 == $1 ? $0 : nil }
            if diff.count == left.count - 1 {
                return String(diff)
            }
        }
    }
    fatalError("Match not found")
}

let part1Range = Array(2...3)

let part1Example = [
    "abcdef", "bababc", "abbcde", "abcccd",
    "abcccd", "abcdee", "ababab"
]
XCTAssertEqual(p1(part1Example, part1Range), 12)

let part2Example = [ "abcde", "fghij", "klmno", "pqrst", "fguij", "axcye", "wvxyz" ]
XCTAssertEqual(p2(part2Example), "fgij")


print("Part 1", p1(input, part1Range))

print("Part 2", p2(input))

//: [Next](@next)
