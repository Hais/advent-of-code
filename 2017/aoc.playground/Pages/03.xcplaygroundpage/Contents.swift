//: [Previous](@previous)

import Foundation
import XCTest

let square: (Int) -> Int = { Int(pow(Double($0),Double(2))) }
let squareRoot: (Int) -> Int = { Int(ceil(sqrt(Double($0))))}


let squareSize: (Int) -> Int = {
    let max = squareRoot($0) + 1
    for i in Array(1...max) {
        let s = square(i)
        if s >= $0, s % 2 == 1 {
            return i
        }
    }
    return 0
}

let part1: (Int) -> Int = { i in
    guard i > 1 else { return 0 } // lazy fix
    let size = squareSize(i)
    let distanceToAxis = (size - 1)/2
    let sideNum = ((square(size) - i) % (size-1))
    let a = max(sideNum - distanceToAxis, distanceToAxis - sideNum)
    let b = distanceToAxis
    return a + b
}

XCTAssertEqual(part1(1), 0)
XCTAssertEqual(part1(12), 3)
XCTAssertEqual(part1(23), 2)
XCTAssertEqual(part1(1024), 31)

print("Part 1 is: ", part1(289326))


//: [Next](@next)
