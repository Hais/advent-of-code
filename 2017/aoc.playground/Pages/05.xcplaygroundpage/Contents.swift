//: [Previous](@previous)

import Foundation
import XCTest


let fileURL = Bundle.main.url(forResource: "input", withExtension: "txt")
let content = try String(contentsOf: fileURL!, encoding: String.Encoding.utf8)
let input = content.split(separator: "\n").map { Int("\($0)") }.flatMap { $0 }

let example = [0, 3, 0, 1, -3]

XCTAssertEqual(part1(example), 5)
XCTAssertEqual(part2(example), 10)

print("Part 1 answer is:", part1(input))
print("Part 2 answer is:", part2(input))

//: [Next](@next)
