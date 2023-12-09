//
//  Day09.swift
//
//
//  Created by Clemens Beck on 09.12.23.
//

struct Day09: AdventDay {
    var data: String
    var rows: [[Int]]

    init(data: String) {
        self.data = data

        rows = data
            .split(separator: "\n")
            .map { $0.split(separator: " ")
                    .map { String($0) }
                    .compactMap { Int($0) }
            }
    }

    func part1() -> Any {
        return rows
            .map { extrapolate(row: $0) }
            .reduce(0, +)
    }

    func part2() -> Any {
        return rows
            .map { $0.reversed() }
            .map { extrapolate(row: $0) }
            .reduce(0, +)
    }

    func differences(row: [Int]) -> [Int] {
        row.enumerated().compactMap { (index, value) in
            if index == row.endIndex - 1 {
                return nil
            }
            return row[index + 1] - value
        }
    }

    func extrapolate(row: [Int]) -> Int {
        var values: [[Int]] = [row]
        var last = values[values.endIndex - 1]
        while last.allSatisfy({ $0 == 0 }) != true {
            values += [differences(row: last)]
            last = values[values.endIndex - 1]
        }
        return values.compactMap(\.last).reduce(0, +)
    }
}


