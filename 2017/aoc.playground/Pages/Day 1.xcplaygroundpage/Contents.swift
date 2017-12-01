import Foundation
import XCTest

// The core logic
let captcha: (([Int], Int) -> Int) = {
    let a = $0 + $0
    return zip(a[0..<$0.count], a[$1...]).map { $0 == $1 ? $0 : 0 }.reduce(0, +)
}

// Functions for Part 1 and 2 respectively
let p1: ([Int]) -> Int = { captcha($0, 1) }
let p2: ([Int]) -> Int = { captcha($0, $0.count / 2) }

// Part 1: Assertions based on the examples
XCTAssertEqual(p1([1,1,2,2]), 3)
XCTAssertEqual(p1([1,1,1,1]), 4)
XCTAssertEqual(p1([1,2,3,4]), 0)
XCTAssertEqual(p1([9,1,2,1,2,1,2,9]), 9)


// Part 2: Assertions based on the examples
XCTAssertEqual(p2([1,2,1,2]), 6)
XCTAssertEqual(p2([1,2,2,1]), 0)
XCTAssertEqual(p2([1,2,3,4,2,5]), 4)
XCTAssertEqual(p2([1,2,3,1,2,3]), 12)
XCTAssertEqual(p2([1,2,1,3,1,4,1,5]), 4)


let fileURL = Bundle.main.url(forResource: "Input", withExtension: "txt")
let content = try String(contentsOf: fileURL!, encoding: String.Encoding.utf8)
let i = content.characters.map{ Int("\($0)") }.flatMap { $0 }

print("Answer to part 1:", p1(i))
print("Answer to part 2:", p2(i))

