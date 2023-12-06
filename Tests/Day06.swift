//
//  Day06.swift
//
//
//  Created by Clemens Beck on 06.12.23.
//

import XCTest

@testable import AdventOfCode

final class Day06Tests: XCTestCase {

    let testData = """
    Time:      7  15   30
    Distance:  9  40  200
    """

    func testPart1() throws {
        let challenge = Day06(data: testData)
        XCTAssertEqual(String(describing: challenge.part1()), "288")
    }

    func testPart2() async throws {
        let challenge = Day06(data: testData)
        XCTAssertEqual(String(describing: challenge.part2()), "71503")
    }
}

