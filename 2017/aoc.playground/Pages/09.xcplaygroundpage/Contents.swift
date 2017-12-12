//: [Previous](@previous)

import Foundation
import XCTest


let parse: (String) -> (groups: Int, garbage: Int) = {
    var cur = 0, groupCount = 0, nesting = 0, garbageCount = 0, garbage = false
    let str = $0.characters.map(String.init)
    repeat {
        switch (str[cur], garbage) {
        case ("!", _): cur += 1
        case ("{", false): nesting += 1
        case ("}", false): groupCount += nesting; nesting -= 1
        case ("<", false): garbage = true
        case (">", _): garbage = false
        case (_, true): garbageCount += 1
        default: break
        }
        cur += 1
    } while (cur < str.count)
    return (groups: groupCount, garbage: garbageCount)
}


// Part 1 assertions
XCTAssertEqual(parse("{}").groups, 1)
XCTAssertEqual(parse("{{{}}}").groups, 6)
XCTAssertEqual(parse("{{},{}}").groups, 5)
XCTAssertEqual(parse("{{{},{},{{}}}}").groups, 16)
XCTAssertEqual(parse("{<a>,<a>,<a>,<a>}").groups, 1)
XCTAssertEqual(parse("{{<ab>},{<ab>},{<ab>},{<ab>}}").groups, 9)
XCTAssertEqual(parse("{{<!!>},{<!!>},{<!!>},{<!!>}}").groups, 9)
XCTAssertEqual(parse("{{<a!>},{<a!>},{<a!>},{<ab>}}").groups, 3)


// Part 2 assertions
XCTAssertEqual(parse("<>").garbage, 0)
XCTAssertEqual(parse("<random characters>").garbage, 17)
XCTAssertEqual(parse("<<<<>").garbage, 3)
XCTAssertEqual(parse("<{!>}>").garbage, 2)
XCTAssertEqual(parse("<!!>").garbage, 0)
XCTAssertEqual(parse("<!!!>>").garbage, 0)
XCTAssertEqual(parse("<{o\"i!a,<{i<a>").garbage, 10)


// Read input and parse
let fileURL = Bundle.main.url(forResource: "input", withExtension: "txt")
let content = try String(contentsOf: fileURL!, encoding: String.Encoding.utf8)

let (part1, part2) = parse(content)

print("Part 1", part1)
print("Part 2", part2)


//: [Next](@next)

