//
//  Day09.swift
//
//
//  Created by Clemens Beck on 09.12.23.
//

import XCTest

@testable import AdventOfCode

final class Day09Tests: XCTestCase {

    let testData = """
    0 3 6 9 12 15
    1 3 6 10 15 21
    10 13 16 21 30 45
    """

    func testPart1() throws {
        let challenge = Day09(data: testData)
        XCTAssertEqual(String(describing: challenge.part1()), "114")
    }

    func testPart2() throws {
        let challenge = Day09(data: testData)
        XCTAssertEqual(String(describing: challenge.part2()), "2")
    }

    func test_extracting_differences() throws {
        let challenge = Day09(data: testData)
        XCTAssertEqual(String(describing: challenge.differences(row: [0, 3, 6, 9, 12, 15])), "[3, 3, 3, 3, 3]")
    }

    func test_extrapolation() throws {
        let challenge = Day09(data: testData)
        XCTAssertEqual(String(describing: challenge.extrapolate(row: [10, 13, 16, 21, 30, 45])), "68")
    }
}

