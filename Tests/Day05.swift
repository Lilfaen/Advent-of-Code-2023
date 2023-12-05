//
//  Day05.swift
//  
//
//  Created by Clemens Beck on 05.12.23.
//

import XCTest

@testable import AdventOfCode

final class Day05Tests: XCTestCase {

    let testData = """
    seeds: 79 14 55 13

    seed-to-soil map:
    50 98 2
    52 50 48

    soil-to-fertilizer map:
    0 15 37
    37 52 2
    39 0 15

    fertilizer-to-water map:
    49 53 8
    0 11 42
    42 0 7
    57 7 4

    water-to-light map:
    88 18 7
    18 25 70

    light-to-temperature map:
    45 77 23
    81 45 19
    68 64 13

    temperature-to-humidity map:
    0 69 1
    1 0 69

    humidity-to-location map:
    60 56 37
    56 93 4
    """

    func testPart1() throws {
        let challenge = Day05(data: testData)
        XCTAssertEqual(String(describing: challenge.part1()), "35")
    }

    func test_extract_seed_numbers() throws {
        let challenge = Day05(data: testData)

        XCTAssertEqual(String(describing: challenge.extractSeedNumbers()), "[79, 14, 55, 13]")
    }

    func test_generic_map_with_seed_to_soil() throws {
        let challenge = Day05(data: testData)
        XCTAssertEqual(String(describing: challenge.mapXtoY(block: "seed-to-soil", number: 13)), "13")
    }

    func test_generic_map_with_soil_to_fertilizer() throws {
        let challenge = Day05(data: testData)
        XCTAssertEqual(String(describing: challenge.mapXtoY(block: "soil-to-fertilizer", number: 13)), "52")
    }

    func test_generic_map_with_fertilizer_to_water() throws {
        let challenge = Day05(data: testData)
        XCTAssertEqual(String(describing: challenge.mapXtoY(block: "fertilizer-to-water", number: 52)), "41")
    }

    func test_generic_map_with_water_to_light() throws {
        let challenge = Day05(data: testData)
        XCTAssertEqual(String(describing: challenge.mapXtoY(block: "water-to-light", number: 41)), "34")
    }

    func test_generic_map_with_light_to_temperature() throws {
        let challenge = Day05(data: testData)
        XCTAssertEqual(String(describing: challenge.mapXtoY(block: "light-to-temperature", number: 34)), "34")
    }

    func test_generic_map_with_temperature_to_humidity() throws {
        let challenge = Day05(data: testData)
        XCTAssertEqual(String(describing: challenge.mapXtoY(block: "temperature-to-humidity", number: 34)), "35")
    }

    func test_generic_map_with_humidity_to_location() throws {
        let challenge = Day05(data: testData)
        XCTAssertEqual(String(describing: challenge.mapXtoY(block: "humidity-to-location", number: 35)), "35")
    }

    func testPart2() async throws {
        let challenge = Day05(data: testData)
        let result = await challenge.part2()
        XCTAssertEqual(String(describing: result), "46")
    }
}
