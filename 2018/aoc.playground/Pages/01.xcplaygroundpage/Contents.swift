//: [Previous](@previous)

import Foundation
import XCTest

let input = try!
    String(
        contentsOf: Bundle.main.url(forResource: "input", withExtension: "txt")!,
        encoding: .utf8
    )
    .components(separatedBy: .newlines)
    .compactMap(Int.init)



let p1: ([Int]) -> Int = { $0.reduce(0, +) }

// Part 1 assertions
XCTAssertEqual(p1([+1, +1, +1]), 3)
XCTAssertEqual(p1([+1, +1, -2]), 0)
XCTAssertEqual(p1([-1, -2, -3]), -6)



let p2: ([Int]) -> Int = {
    var f = 0;
    var h = Set<Int>([f])
    repeat {
        let fs = $0.reduce(into: [f]) { $0.append($0.last! + $1) }
        if let found = fs[1...].first(where: { i in
            defer { h.insert(i) }
            return h.contains(i)
        }) { return found }
        f = fs.last!
    } while true
}

// Part 2 assertions
XCTAssertEqual(p2([+1, -1]), 0)
XCTAssertEqual(p2([+3, +3, +4, -2, -4]), 10)
XCTAssertEqual(p2([-6, +3, +8, +5, -6]), 5)
XCTAssertEqual(p2([+7, +7, -2, -7, -4]), 14)




print("Part 1", p1(input))
print("Part 2", p2(input))

//: [Next](@next)
