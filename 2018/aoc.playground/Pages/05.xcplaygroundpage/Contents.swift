//: [Previous](@previous)

import Foundation
//import XCTest

let input: String = {
    
    let url: URL
    
    if CommandLine.arguments.count > 0, let file = CommandLine.arguments.last, file.count > 0 {
        print("Opening", file)
        url  = URL.init(fileURLWithPath: file)
    } else {
        url = Bundle.main.url(forResource: "input", withExtension: "txt")!
    }
    
    return try! String(
        contentsOf: url,
        encoding: .utf8
    ).replacingOccurrences(of: "\n", with: "")
}()

extension UInt32 {
    var lowercased: UInt32 { return isLowercase ? self : self + 32 }
    var uppercased: UInt32 { return isUppercase ? self : self - 32 }
    var isUppercase: Bool { return self < 97 }
    var isLowercase: Bool { return self > 96 }
    var c: String { return String(UnicodeScalar(self)!) }
}

extension String {
    var ints: [UInt32] {  return self.map { UnicodeScalar(String($0))!.value } }
}

func isPolymer (_ lhs: UInt32, _ rhs: UInt32) -> Bool {
    guard lhs != rhs, lhs.lowercased == rhs.lowercased
        else { return false }
    return (lhs.isLowercase && rhs.isUppercase)
        || (rhs.isLowercase && lhs.isUppercase)
}

let chemistry: ([UInt32]) -> [UInt32] = {
    return $0.reduce([UInt32](), { prev, char in
        let prevChar = prev.last ?? 0
        if isPolymer(prevChar, char) {
            return Array(prev.dropLast())
        }
        return prev + [char]
    })
}

//XCTAssertEqual(String(chemistry("dabAcCaCBAcCcaDA").map { UnicodeScalar($0)! }), "dabCBAcaDA")
//XCTAssertEqual(p2("dabAcCaCBAcCcaDA"), 4)

let ints = input.ints
let p1 = chemistry(ints)
print("Part 1", p1.count) // 11364

let p2: ([UInt32]) -> Int = { p2input in
    let inputLength = p2input.count
    let counts = p2input.enumerated().reduce(into: [UInt32: Int](), { prev, it in
        let (i, current) = it
        let lc = current.lowercased
        prev[lc] = (prev[lc] ?? 0) + 1
        guard (1..<inputLength) ~= i else { return }
        let prevChar = p2input[i-1]
        guard
            prevChar.lowercased != lc,
            let nextCharIdx = p2input[i...].firstIndex(where: { $0.lowercased != lc }) else { return }
        let nextChar = p2input[nextCharIdx]
        if isPolymer(prevChar, nextChar) {
            prev[lc] = prev[lc]! + 2
            var ii = 1
            while isPolymer(p2input[i-ii-1], p2input[nextCharIdx+ii]) {
                ii += 1
                prev[lc] = prev[lc]! + 2
            }
        }
        
    }).sorted { $0.value > $1.value }
    let uc = counts.first!.key.uppercased
    let lc = counts.first!.key.lowercased
    return chemistry(p2input.filter { $0 != uc && $0 != lc }).count
}

print("Part 2", p2(p1)) // 4212

//: [Next](@next)
