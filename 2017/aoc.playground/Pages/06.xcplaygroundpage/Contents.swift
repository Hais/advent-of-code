//: [Previous](@previous)

import Foundation
import XCTest

let example = [0, 2, 7, 0]
let input = [4, 1, 15, 12, 0, 9, 9, 5, 5, 8, 7, 3, 14, 5, 12, 3]

let (exampleCycles, exampleLoop) = run(input: example)

XCTAssertEqual(exampleCycles, 5)
XCTAssertEqual(exampleLoop, 4)

let (part1, part2) = run(input: input)

print("Answer to part1", part1)
print("Answer to part2", part2)

//: [Next](@next)
