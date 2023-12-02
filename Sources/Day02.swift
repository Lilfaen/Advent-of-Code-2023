//
//  Day02.swift
//
//
//  Created by Clemens Beck on 02.12.23.
//

import RegexBuilder

struct Day02: AdventDay {
    var data: String

    enum CubeColor: String {
        case red, green, blue

        var maxCount: Int {
            switch self {
            case .red: 12
            case .green: 13
            case .blue: 14
            }
        }
    }

    func part1() -> Any {
        var sum = 0

        let lines = data.split(separator: "\n").map { String($0) }
        for line in lines {
            var string = line
            let gameId = getGameId(inputString: &string)

            var everyComboPossible = true
            let randomGrabs = string.split(separator: ";")
            for randomGrab in randomGrabs {
                guard extractCubeInfo(inputString: String(randomGrab)) else {
                    everyComboPossible = false
                    continue
                }
            }

            if everyComboPossible {
                sum += gameId ?? 0
            }
        }

        return sum
    }

    func getGameId(inputString: inout String) -> Int? {
        let gameIdRegex = Regex {
            "Game "
            Capture {
                OneOrMore(.digit)
            }
            ": "
        }

        if let match = inputString.firstMatch(of: gameIdRegex) {
            inputString = String(inputString.trimmingPrefix(gameIdRegex))
            return Int(match.1)
        }
        return nil
    }

    func extractCubeInfo(inputString: String) -> Bool {
        let cubeInfoRegex = Regex {
            Capture {
                OneOrMore(.digit)
            }
            One(.whitespace)
            Capture {
                ChoiceOf {
                    "blue"
                    "red"
                    "green"
                }
            }
        }

        let colors = inputString.split(separator: ",")
        for color in colors {
            if let match = color.firstMatch(of: cubeInfoRegex) {
                let cubeColor = CubeColor(rawValue: (String(match.2)))!
                guard comboIsPossible(color: cubeColor, int: Int(match.1)!) else {
                    return false
                }
            }
        }

        return true
    }

    func comboIsPossible(color: CubeColor, int: Int) -> Bool {
        return int <= color.maxCount
    }

    func part2() -> Any {
        var sum: Int = 0

        let lines = data.split(separator: "\n").map { String($0) }
        for line in lines {
            var string = line
            _ = getGameId(inputString: &string)

            let min = getMinimum(inputString: string)
            if let minRed = min[.red],
               let minGreen = min[.green],
               let minBlue = min[.blue] {
                sum += minRed * minGreen * minBlue
            }
        }

        return sum
    }

    func getMinimum(inputString: String) -> [CubeColor: Int] {
        var colorMin: [CubeColor: Int] = [:]

        let randomGrabs = inputString.split(separator: ";")
        for randomGrab in randomGrabs {
            let colors = randomGrab.split(separator: ",")
            for color in colors {
                let colorCount: (CubeColor?, Int?) = getCount(inputString: String(color))

                if let color = colorCount.0,
                   let count = colorCount.1,
                   count > colorMin[color] ?? 0 {
                    colorMin[color] = count
                }
            }
        }

        return colorMin
    }

    func getCount(inputString: String) -> (CubeColor?, Int?) {
        let cubeInfoRegex = Regex {
            Capture {
                OneOrMore(.digit)
            }
            One(.whitespace)
            Capture {
                ChoiceOf {
                    "blue"
                    "red"
                    "green"
                }
            }
        }

        if let match = inputString.firstMatch(of: cubeInfoRegex) {
            let cubeColor = CubeColor(rawValue: (String(match.2)))!
            let count = Int(match.1)!
            return (cubeColor, count)
        }

        return (nil, nil)
    }
}
