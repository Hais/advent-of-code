//: [Previous](@previous)

import Foundation

let input: [String] = try!
    String(
        contentsOf: Bundle.main.url(forResource: "input", withExtension: "txt")!,
        encoding: .utf8
        )
        .components(separatedBy: .newlines)

// coulda used GCRect but that converts to GCFloat
typealias Claim = (ID: Int, x: Int, y: Int, width: Int, height: Int)

let claims = input
    .map{
        $0.components(separatedBy: CharacterSet(charactersIn: "#@,x: ")).compactMap(Int.init)
    }
    .filter { $0.count >= 5 }
    .map {
        Claim(ID: $0[0], x: $0[1], y: $0[2], width: $0[3], height: $0[4])
    }

let gridSize = claims.map { max($0.width + $0.x, $0.height + $0.y) }.reduce(0, max) + 1
var grid: [[Int]] = Array(repeating: Array(repeating: 0, count: gridSize), count: gridSize)
var intersecting = Array(repeating: false, count: claims.count + 1)

for c in claims {
    for x in c.x..<c.x+c.width {
        for y in c.y..<c.y+c.height {
            // 0 = not claimed; 0< = claimed once
            let val = grid[x][y]
            if val == 0 {
                grid[x][y] = c.ID
                continue
            } else if val > 0 {
                intersecting[val] = true
            }
            intersecting[c.ID] = true
        }
    }
}

let p1 = grid.map { $0.filter { $0 > 1 }.count }.reduce(0, +)

let p2 = intersecting[1...].enumerated().first{ _,v in !v }!.offset + 1

print("Part 1", p1)
print("Part 2", p2)
//: [Next](@next)
