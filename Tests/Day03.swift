//
//  Day03.swift
//  
//
//  Created by Clemens Beck on 03.12.23.
//

import XCTest

@testable import AdventOfCode

final class Day03Tests: XCTestCase {

    let testData = """
    467..114..
    ...*......
    ..35..633.
    ......#...
    617*......
    .....+.58.
    ..592.....
    ......755.
    ...$.*....
    .664.598..
    """

    let symbols: [Day03.Symbol] = [
        .init(line: 1,column: 3),
        .init(line: 3,column: 6),
        .init(line: 4,column: 3),
        .init(line: 5,column: 5),
        .init(line: 8,column: 3),
        .init(line: 8,column: 5)
    ]

    let numbers: [Day03.Number] = [
        .init(line: 0, columns: [0, 1, 2], value: 467),
        .init(line: 0, columns: [5, 6, 7], value: 114),
        .init(line: 2, columns: [2, 3], value: 35),
        .init(line: 2, columns: [6, 7, 8], value: 633),
        .init(line: 4, columns: [0, 1, 2], value: 617),
        .init(line: 5, columns: [7, 8], value: 58),
        .init(line: 6, columns: [2, 3, 4], value: 592),
        .init(line: 7, columns: [6, 7, 8], value: 755),
        .init(line: 9, columns: [1, 2, 3], value: 664),
        .init(line: 9, columns: [5, 6, 7], value: 598)
    ]

    let numbersWithAdjacentSymbols: [Day03.Number] = [
        .init(line: 0, columns: [0, 1, 2], value: 467),
        .init(line: 2, columns: [2, 3], value: 35),
        .init(line: 2, columns: [6, 7, 8], value: 633),
        .init(line: 4, columns: [0, 1, 2], value: 617),
        .init(line: 6, columns: [2, 3, 4], value: 592),
        .init(line: 7, columns: [6, 7, 8], value: 755),
        .init(line: 9, columns: [1, 2, 3], value: 664),
        .init(line: 9, columns: [5, 6, 7], value: 598)
    ]

    func testPart1() throws {
        let challenge = Day03(data: testData)
        XCTAssertEqual(String(describing: challenge.part1()), "4361")
    }

    func test_symbol_finder() throws {
        let challenge = Day03(data: testData)
        XCTAssertEqual(challenge.symbolFinder(), symbols)
    }

    func test_number_finder() throws {
        let challenge = Day03(data: testData)
        XCTAssertEqual(challenge.numberFinder(), numbers)
    }

    func test_adjacent_symbol_finder() throws {
        let challenge = Day03(data: testData)
        XCTAssertEqual(challenge.checkAdjacentSymbols(numbers: numbers, symbols: symbols), numbersWithAdjacentSymbols)
    }

    func testPart2() throws {
        let challenge = Day03(data: testData)
        XCTAssertEqual(String(describing: challenge.part2()), "467835")
    }

    func test_gear_finder() throws {
        let challenge = Day03(data: testData)
        XCTAssertEqual(challenge.findGearSymbolWithTwoAdjacentNumbers(numbers: numbers), 467835)
    }
}

