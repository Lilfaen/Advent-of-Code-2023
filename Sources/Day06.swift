//
//  Day06.swift
//
//
//  Created by Clemens Beck on 06.12.23.
//

struct Day06: AdventDay {
    var data: String

    func part1() -> Any {
        let lines = data.split(separator: "\n")

        let times = lines[0]
            .trimmingPrefix(#/Time:\s*/#)
            .split(separator: " ")
            .compactMap { Int($0) }

        let distances = lines[1]
            .trimmingPrefix(#/Distance:\s*/#)
            .split(separator: " ")
            .compactMap { Int($0) }

        let races = Array(zip(times, distances)).map { (time: $0.0, distance: $0.1)}

        var possibleWins: [Int] = []
        for race in races {
            var winningButtonDuration: [Int] = []
            for ms in 0...race.time {
                if ms * (race.time - ms) > race.distance {
                    winningButtonDuration.append(ms)
                }
            }
            possibleWins.append(winningButtonDuration.count)
        }

        return possibleWins.reduce(1, *)
    }

    func part2() -> Any {
        let lines = data.split(separator: "\n")

        let timeString = lines[0]
            .trimmingPrefix(#/Time:\s*/#)
            .replacingOccurrences(of: " ", with: "")

        guard let time = Int(timeString) else { return -1 }

        let distanceString = lines[1]
            .trimmingPrefix(#/Distance:\s*/#)
            .replacingOccurrences(of: " ", with: "")

        guard let distance = Int(distanceString) else { return -1}

        var possibleWins: Int = 0
        var buttonHeld = time / 2

        while (time - buttonHeld) * buttonHeld > distance {
            possibleWins += 1
            buttonHeld -= 1
        }

        return (possibleWins * 2) + (time % 2 - 1)
    }
}
