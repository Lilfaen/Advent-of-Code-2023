//
//  Day08.swift
//
//
//  Created by Clemens Beck on 08.12.23.
//

import XCTest

@testable import AdventOfCode

final class Day08Tests: XCTestCase {

    let testDataPart1 = """
    LLR

    AAA = (BBB, BBB)
    BBB = (AAA, ZZZ)
    ZZZ = (ZZZ, ZZZ)
    """

    func testPart1() throws {
        let challenge = Day08(data: testDataPart1)
        XCTAssertEqual(String(describing: challenge.part1()), "6")
    }

    let testDataPart2 = """
    LR

    11A = (11B, XXX)
    11B = (XXX, 11Z)
    11Z = (11B, XXX)
    22A = (22B, XXX)
    22B = (22C, 22C)
    22C = (22Z, 22Z)
    22Z = (22B, 22B)
    XXX = (XXX, XXX)
    """

    func testPart2() throws {
        let challenge = Day08(data: testDataPart2)
        XCTAssertEqual(String(describing: challenge.part2()), "6")
    }

    let testData = """
    RL

    AAA = (BBB, CCC)
    BBB = (DDD, EEE)
    CCC = (ZZZ, GGG)
    DDD = (DDD, DDD)
    EEE = (EEE, EEE)
    GGG = (GGG, GGG)
    ZZZ = (ZZZ, ZZZ)
    """

    func test_count_steps() throws {
        let challenge = Day08(data: testData)
        XCTAssertEqual(String(describing: challenge.part1()), "2")
    }

    func test_lcm_with_vector() throws {
        let challenge = Day08(data: testData)
        XCTAssertEqual(String(describing: challenge.lcm([4, 6, 8])), "24")
    }

    func test_lcm_with_integers() throws {
        let challenge = Day08(data: testData)
        XCTAssertEqual(String(describing: challenge.lcm(a: 6, b: 8)), "24")
    }

    func test_gcd_with_vector() throws {
        let challenge = Day08(data: testData)
        XCTAssertEqual(String(describing: challenge.gcd(vector: [4, 6, 8])), "2")
    }

    func test_gcd_with_integers() throws {
        let challenge = Day08(data: testData)
        XCTAssertEqual(String(describing: challenge.gcd(a: 6, b: 8)), "2")
    }
}
