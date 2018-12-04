//: [Previous](@previous)

import Foundation

/**
 input array parsed to ints:
 
 i.e.
 [1518-02-11 23:50] Guard #113 begins shift
 [1518-02-12 00:00] falls asleep
 [1518-02-12 00:46] wakes up
 [1518-02-12 00:53] falls asleep
 [1518-02-12 00:56] wakes up
 
 becomes:
 [
     [23, 50, 113],
     [0, 0],
     [0, 46],
     [0, 53],
     [0, 56]
 ]
 **/

let unfilteredInput: [[Int]] = try!
    String(
        contentsOf: Bundle.main.url(forResource: "input", withExtension: "txt")!,
        encoding: .utf8
    )
    .components(separatedBy: .newlines)
    .sorted()
    .map{  $0.components(separatedBy: CharacterSet(charactersIn: "[]#@,x: ")).compactMap(Int.init) }
        
let input =
    unfilteredInput
        .enumerated()
        .compactMap { it -> [Int]? in
            let (i, val) = it
            guard val.count > 1 else { return nil }     // filter empty rows
            guard val.count > 2 else { return val }     // filter guards that didn't sleep
            guard i <= unfilteredInput.count, unfilteredInput[i+1].count > 2 else { return val }
            return nil
        }

// Start of guard shift is denoted by array of 3 ints
let isStart: ([Int]) -> Bool = { $0.count > 2 }

/**
 zip of guardId's and sleep/wake events
 
 i.e.
 [
     [23, 50, 113],
     [0, 0],
     [0, 46],
     [0, 53],
     [0, 56]
 ]
 
 becomes:
 (113, [[0, 0], [0, 46], [0, 53], [0, 56]])

 **/
let zippedInput = zip(
    input.filter(isStart).map { $0[2] },
    input.split(whereSeparator: isStart)
)


// produces map of [GuardID: [MinsSlept]]
let guardHours = zippedInput.reduce(into: [Int:[Int]]()) { (result, inputs) in
    let (guardId, events) = inputs
    var mins = result[guardId] ?? []

    var it = events.makeIterator()
    while let sleep = it.next(), let awake = it.next()  {
        mins = mins + Array(sleep[1]..<awake[1])
    }

    result[guardId] = mins
}

// helper to aggregate and sort by highest frequency first
let count: ([Int]) -> [(key: Int, value: Int)] = {
    return Dictionary(grouping: $0, by: { $0 })
        .mapValues { $0.count }
        .sorted { $0.value > $1.value }
}


let (p1GuardId, mins) = guardHours.sorted { $0.value.count > $1.value.count }.first!
let unqiue = count(mins).first!.key

print("Part 1", p1GuardId * unqiue)

let (p2Guard, min) = guardHours.mapValues { count($0).first! }.sorted { $0.value.value > $1.value.value } .first!

print("Part 2", p2Guard * min.key)

//: [Next](@next)
