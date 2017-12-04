//: [Previous](@previous)

import Foundation
import XCTest


let p1 = { (i: [String]) -> Bool in i.count == Set<String>(i).count }
let p2 = { (i: [String]) -> Bool in p1(i.map { $0.characters.sorted() }.map{ "\($0)" }) }

let countValid: ([[String]], ([String]) -> Bool) -> Int = { arr, fn in arr.map(fn).map{ $0 ? 1 : 0 }.reduce(0, +) }

// read input file
let fileURL = Bundle.main.url(forResource: "input", withExtension: "txt")
let content = try String(contentsOf: fileURL!, encoding: String.Encoding.utf8)
let words = content.split(separator: "\n").map { $0.split(separator: " ").map { "\($0)" } }


XCTAssertTrue(p1(["aa", "bb", "cc", "dd", "ee"]))
XCTAssertFalse(p1(["aa", "bb", "cc", "dd", "aa"]))
XCTAssertTrue(p1(["aa", "bb", "cc", "dd", "aaa"]))

print("Part 1 is", countValid(words, p1))

XCTAssertTrue(p2(["abcde", "fghij"]))
XCTAssertFalse(p2(["abcde", "xyz", "ecdab"]))
XCTAssertTrue(p2(["a", "ab", "abc", "abd", "abf", "abj"]))
XCTAssertTrue(p2(["iiii", "oiii", "ooii", "oooi", "oooo"]))
XCTAssertFalse(p2(["oiii", "ioii", "iioi", "iiio", "is"]))

print("Part 2 is", countValid(words, p2))

//: [Next](@next)
