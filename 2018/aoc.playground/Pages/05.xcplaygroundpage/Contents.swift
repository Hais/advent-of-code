//: [Previous](@previous)

import Foundation
import XCTest

let input = try!
    String(
        contentsOf: Bundle.main.url(forResource: "input", withExtension: "txt")!,
        encoding: .utf8
    ).replacingOccurrences(of: "\n", with: "")

// glaring omissions from the stdlib
extension Character {
    var lowercased: Character { return String(self).lowercased().first! }
    var uppercased: Character { return String(self).uppercased().first! }
    var isUppercase: Bool { return CharacterSet.uppercaseLetters.contains(UnicodeScalar(String(self))!) }
    var isLowercase: Bool { return CharacterSet.lowercaseLetters.contains(UnicodeScalar(String(self))!) }
}

func isPolymer (_ lhs: Character, _ rhs: Character) -> Bool {
    guard lhs != rhs, lhs.lowercased == rhs.lowercased
        else { return false }
    return (lhs.isLowercase && rhs.isUppercase)
        || (rhs.isLowercase && lhs.isUppercase)
}

let chemistry: (String) -> [Character] = {
    return Array($0).reduce(Array(""), { prev, char in
        if let prevChar = prev.last, isPolymer(prevChar, char) {
            return Array(prev.dropLast())
        }
        return prev + [char]
    })
}


let p2: (String) -> Int = { input in
    (97...122).reduce(into: [String:Int]()) {
        let char = String(UnicodeScalar($1)!)
        $0[char] = chemistry(input
            .replacingOccurrences(of: char, with: "")
            .replacingOccurrences(of: char.uppercased(), with: "")).count
        
    }.sorted { $0.value > $1.value }.last!.value
}


XCTAssertEqual(String(chemistry("dabAcCaCBAcCcaDA")), "dabCBAcaDA")
XCTAssertEqual(p2("dabAcCaCBAcCcaDA"), 4)


print("Part 1", chemistry(input).count)

print("Part 2", p2(input))

//: [Next](@next)
