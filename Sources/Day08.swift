//
//  Day08.swift
//
//
//  Created by Clemens Beck on 08.12.23.
//

import RegexBuilder

struct Day08: AdventDay {
    var data: String

    let maps: [Map]
    let instructions: [String]

    init(data: String) {
        self.data = data

        var lines = data.split(separator: "\n")
        instructions = lines[0].split(separator: "").map { String($0) }

        lines.removeFirst()
        maps = lines.compactMap { line in
            let node = Reference<String>()
            let left = Reference<String>()
            let right = Reference<String>()

            let regex = Regex {
                TryCapture(as: node) {
                    OneOrMore(.word)
                } transform: { w in
                    String(w)
                }
                One(" = (")
                TryCapture(as: left) {
                    OneOrMore(.word)
                } transform: { w in
                    String(w)
                }
                One(", ")
                TryCapture(as: right) {
                    OneOrMore(.word)
                } transform: { w in
                    String(w)
                }
                One(")")
            }

            if let match = line.wholeMatch(of: regex) {
                return Map(
                    node: match[node],
                    left: match[left],
                    right: match[right]
                )
            }
            return nil
        }
    }

    func part1() -> Any {
        let start = "AAA"
        let finish = "ZZZ"
        let stepCount = countSteps(from: start, startSuffix: start, endSuffix: finish)
        return stepCount
    }

    func part2() -> Any {
        let startSuffix = "A"
        let finishSuffix = "Z"
        let startPositions = maps.filter { $0.node.hasSuffix("A")}
        let stepCounts = startPositions.map { countSteps(from: $0.node, startSuffix: startSuffix, endSuffix: finishSuffix) }
        return lcm(stepCounts)
    }

    func countSteps(from start: String, startSuffix: String, endSuffix: String) -> Int {
        var steps = 0
        var current = start
        while !current.hasSuffix(endSuffix) {
            let instruction = instructions[steps % instructions.count]
            switch instruction {
            case "L":
                current = maps.first { $0.node == current }!.left
            case "R":
                current = maps.first { $0.node == current }!.right
            default:
                fatalError()
            }
            steps += 1
        }
        return steps
    }

    struct Map {
        var node: String
        var left: String
        var right: String
    }

    func lcm(_ vector : [Int]) -> Int {
        return vector.reduce(1, lcm)
    }

    func lcm(a: Int, b: Int) -> Int {
        return (a / gcd(a: a, b: b)) * b
    }

    func gcd(vector: [Int]) -> Int {
        return vector.reduce(0, gcd)
    }

    func gcd(a: Int, b: Int) -> Int {
        var (a, b) = (a, b)
        while b != 0 {
            (a, b) = (b, a % b)
        }
        return abs(a)
    }

}
