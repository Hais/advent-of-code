
public typealias Modifier = ((Int) -> Int)

let part1Modifier: Modifier = { $0 + 1 }
let part2Modifier: Modifier = { $0 + ($0 >= 3 ? -1 : 1 ) }

public let part1 = { (i: [Int]) -> Int in run(input: i, modifier: part1Modifier) }
public let part2 = { (i: [Int]) -> Int in run(input: i, modifier: part2Modifier) }

func run(input: [Int], modifier: @escaping Modifier) -> Int {
    
    var i = input   // mutable copy of input
    var s = 0       // number of steps taken
    
    // the position of the cursor
    var cur = 0 {
        didSet {
            i[oldValue] = modifier(i[oldValue])
        }
    }
    
    repeat { cur += i[cur]; s += 1 } while (cur < i.count)
    
    return s
}
