//: [Previous](@previous)

import Foundation
import XCTest


// Parse the input TSV
let fileURL = Bundle.main.url(forResource: "input", withExtension: "txt")
let content = try String(contentsOf: fileURL!, encoding: String.Encoding.utf8)
let vals = content.split(separator: "\n").map { $0.split(separator: "\t").map { Int("\($0)") }.flatMap { $0 } }


let part1: (([[Int]]) -> Int) = { $0.map{ $0.sorted() }.map { $0.last! - $0.first! }.reduce(0, +) }


let part1Example = [
    [5, 9, 1, 5],
    [7, 5, 3],
    [2, 4, 6, 8]
]
XCTAssertEqual(part1(part1Example), 18)

let part2: (([[Int]]) -> Int) = {
    $0.map { arr -> Int in
        return arr.enumerated().makeIterator().flatMap { idx, val -> Int? in
            guard let found = arr[(idx + 1)...].first(where: { val % $0 == 0 || $0 % val == 0 }) else { return nil }
            return max(found / val, val / found)
        }.first!
    }.reduce(0, +)
}


let part2Example = [[5, 9, 2, 8], [9,4,7,3], [3,8,6,5]]
XCTAssertEqual(part2(part2Example), 9)


print("Answer to part 1", part1(vals))
print("Answer to part 2", part2(vals))

//: [Next](@next)
