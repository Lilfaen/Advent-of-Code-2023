//
//  Day03.swift
//
//
//  Created by Clemens Beck on 03.12.23.
//

struct Day03: AdventDay {
    var data: String

    func part1() -> Any {

        let symbols = symbolFinder()
        let numbers = numberFinder()

        let numbersWithAdjacentSymbols = checkAdjacentSymbols(numbers: numbers, symbols: symbols)
        let rawValues = numbersWithAdjacentSymbols.map { $0.value }

        return rawValues.reduce(0, +)
    }

    func symbolFinder() -> [Symbol] {
        var symbolLocations: [Symbol] = []

        let lines = data.split(separator: "\n")
        for line in lines.indices {
            let columns = lines[line].split(separator: "")
            for column in columns.indices {
                do {
                    if columns[column].contains(try Regex("[^0-9.]")) {
                        symbolLocations.append(.init(line: line, column: column))
                    }
                } catch {

                }
            }
        }

        return symbolLocations
    }

    func numberFinder() -> [Number] {
        var numbers: [Number] = []

        let lines = data.split(separator: "\n")
        for line in lines.indices {
            let columns = lines[line].split(separator: "")
            for column in columns.indices {
                do {
                    if columns[column].contains(try Regex("[0-9]")),
                    let value = Int(columns[column]) {
                        if let lastNumber = numbers.last,
                           lastNumber.line == line,
                           lastNumber.columns.contains(column - 1) {
                            let newNumber: Number = .init(
                                line: lastNumber.line,
                                columns: lastNumber.columns + [column],
                                value: Int("\(lastNumber.value)\(value)")!
                            )
                            numbers.removeLast()
                            numbers.append(newNumber)
                        } else {
                            numbers.append(.init(line: line, columns: [column], value: value))
                        }
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }

        return numbers
    }

    func checkAdjacentSymbols(numbers: [Number], symbols: [Symbol]) -> [Number] {
        var numbersWithAdjacentSymbol: [Number] = []

        for number in numbers {
            let symbolsInAdjacentLines = symbols.filter { symbol in
                symbol.line == number.line
                || symbol.line == number.line - 1
                || symbol.line == number.line + 1
            }

            guard symbolsInAdjacentLines.contains(where: { symbol in
                number.columns.contains(symbol.column)
                || number.columns.contains(symbol.column - 1)
                || number.columns.contains(symbol.column + 1)
            }) else { continue }

            numbersWithAdjacentSymbol.append(number)
        }

        return numbersWithAdjacentSymbol
    }

    struct Symbol: Equatable {
        var line: Int
        var column: Int
    }

    struct Number: Equatable {
        var line: Int
        var columns: [Int]
        var value: Int
    }

    func part2() -> Any {
        let numbers = numberFinder()

        let gears = findGearSymbolWithTwoAdjacentNumbers(numbers: numbers)
        return gears
    }

    func findGearSymbolWithTwoAdjacentNumbers(numbers: [Number]) -> Int {
        var gearRatio: [Int] = []

        let lines = data.split(separator: "\n")
        for line in lines.indices {
            let columns = lines[line].split(separator: "")
            for column in columns.indices {
                do {
                    if columns[column].contains(try Regex("[*]")) {
                        let adjacentNumbers = checkAdjacentSymbols(numbers: numbers, symbols: [.init(line: line, column: column)])
                        if adjacentNumbers.count == 2 {
                            gearRatio.append(adjacentNumbers.map { $0.value }.reduce(1, *))
                        }
                    }
                } catch {

                }
            }
        }

        return gearRatio.reduce(0, +)
    }
}
