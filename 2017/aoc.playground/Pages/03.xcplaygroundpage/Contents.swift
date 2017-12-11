//: [Previous](@previous)

import Foundation
import XCTest

let square: (Int) -> Int = { Int(pow(Double($0),Double(2))) }
let squareRoot: (Int) -> Int = { Int(ceil(sqrt(Double($0))))}


let squareSize: (Int) -> Int = {
    let max = squareRoot($0) + 1
    for i in Array((max - 1)...max) {
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
XCTAssertEqual(part1(22), 3)
XCTAssertEqual(part1(1024), 31)

let input = 289326
print("Part 1 is: ", part1(input))

typealias Point = (x: Int, y: Int) // Could be CGPoint but meh



let traverseFn = { (size: Int) -> ((Point?) -> Point) in
    let axis = Int(ceil(Double(size) / 2))
    return { inPoint in
        guard let p = inPoint else { return (x: axis, y: axis) }
        return (x: 1, y: 1)
    }
}

let matrixSize = squareSize(input)
let squares = stride(from: 1, to: matrixSize * 2, by: 1).map { $0 * $0 }
let matrix: [[Int]] = Array(repeatElement(Array(repeating: 0, count: matrixSize), count: matrixSize))

var val = 0
var n = 0

let nextFn = traverseFn(matrixSize)



//repeat {
//    let point = next(n)
//
//
//} while (val < input)

//: [Next](@next)
