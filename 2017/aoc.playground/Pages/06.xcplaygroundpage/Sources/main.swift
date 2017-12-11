import Foundation

struct History: Hashable {
    let n: [Int]
    let c: Int
    
    var hashValue: Int {
        return "\(n)".hashValue
    }
    
    static func == (lhs: History, rhs: History) -> Bool {
        return lhs.n == rhs.n
    }
}

public func run(input: [Int]) -> (cycles: Int, loop: Int){
    var b = input   // mutable input
    var c = 0       // cycles
    var history = Set<History>()
    var hash = History(n: b, c: c)
    
    repeat {
        history.insert(hash)
        
        // largest number
        let largest = b.sorted().last!
        
        // first index with largest number
        let idx = b.makeIterator().enumerated().flatMap { return $1 == largest ? $0 : nil }.first!
        b[idx] = 0 // reset block to 0
        
        var addTo = idx // current index
        var toSpread = largest // items left to spread
        repeat { addTo = (addTo + 1 == b.count) ? 0 : addTo + 1; b[addTo] += 1; toSpread -= 1 } while (toSpread > 0 )
        
        c += 1  // increase cycle count
        hash = History(n: b, c: c) // create new history item
        
    } while (!history.contains(hash))
    
    let firstAt = history.enumerated().first(where: { $1 == hash})!
    let loop = c - firstAt.element.c
    return (cycles: c, loop: loop)
}


