//
//  Day07.swift
//
//
//  Created by Clemens Beck on 07.12.23.
//

import XCTest

@testable import AdventOfCode

final class Day07Tests: XCTestCase {

    let testData = """
    32T3K 765
    T55J5 684
    KK677 28
    KTJJT 220
    QQQJA 483
    """

    func testPart1() throws {
        let challenge = Day07(data: testData)
        XCTAssertEqual(String(describing: challenge.part1()), "6440")
    }

    func test_decide_card_type_five_of_a_kind() throws {
        let challenge = Day07(data: testData)
        XCTAssertEqual(String(describing: challenge.decideCardType(for: "AAAAA")), "fiveOfAKind")
    }

    func test_decide_card_type_four_of_a_kind() throws {
        let challenge = Day07(data: testData)
        XCTAssertEqual(String(describing: challenge.decideCardType(for: "AA8AA")), "fourOfAKind")
    }

    func test_decide_card_type_full_house() throws {
        let challenge = Day07(data: testData)
        XCTAssertEqual(String(describing: challenge.decideCardType(for: "23332")), "fullHouse")
    }

    func test_decide_card_type_three_of_a_kind() throws {
        let challenge = Day07(data: testData)
        XCTAssertEqual(String(describing: challenge.decideCardType(for: "TTT98")), "threeOfAKind")
    }

    func test_decide_card_type_two_pair() throws {
        let challenge = Day07(data: testData)
        XCTAssertEqual(String(describing: challenge.decideCardType(for: "23432")), "twoPair")
    }

    func test_decide_card_type_one_pair() throws {
        let challenge = Day07(data: testData)
        XCTAssertEqual(String(describing: challenge.decideCardType(for: "A23A4")), "onePair")
    }

    func test_decide_card_type_high_card() throws {
        let challenge = Day07(data: testData)
        XCTAssertEqual(String(describing: challenge.decideCardType(for: "23456")), "highCard")
    }

    func test_grouped_hands_sort_part_1() throws {
        let challenge = Day07(data: testData)
        let hands: [Day07.Hand] = [
            .init(value: "QQQJA", bidAmount: 483, type: .threeOfAKind),
            .init(value: "32T3K", bidAmount: 765, type: .onePair),
            .init(value: "KTJJT", bidAmount: 220, type: .twoPair),
            .init(value: "KK677", bidAmount: 28, type: .twoPair),
            .init(value: "T55J5", bidAmount: 684, type: .threeOfAKind),
        ]
        let sortedHands: [Day07.Hand] = [
            .init(value: "32T3K", bidAmount: 765, type: .onePair),
            .init(value: "KTJJT", bidAmount: 220, type: .twoPair),
            .init(value: "KK677", bidAmount: 28, type: .twoPair),
            .init(value: "T55J5", bidAmount: 684, type: .threeOfAKind),
            .init(value: "QQQJA", bidAmount: 483, type: .threeOfAKind),
        ]
        let sortDictPart1 = [
            "2": 2,
            "3": 3,
            "4": 4,
            "5": 5,
            "6": 6,
            "7": 7,
            "8": 8,
            "9": 9,
            "T": 10,
            "J": 11,
            "Q": 12,
            "K": 13,
            "A": 14
        ]
        XCTAssertEqual(String(describing: challenge.groupedHandsSort(hands: hands, sortDict: sortDictPart1)), String(describing: sortedHands))
    }

    func test_calculate_winnings() throws {
        let challenge = Day07(data: testData)
        let hands: [Day07.Hand] = [
            .init(value: "32T3K", bidAmount: 765, type: .onePair),
            .init(value: "T55J5", bidAmount: 684, type: .threeOfAKind),
            .init(value: "KK677", bidAmount: 28, type: .twoPair),
            .init(value: "KTJJT", bidAmount: 220, type: .twoPair),
            .init(value: "QQQJA", bidAmount: 483, type: .threeOfAKind)
        ]

        XCTAssertEqual(String(describing: challenge.calculateWinnings(hands: hands)), "5512")
    }

    func testPart2() async throws {
        let challenge = Day07(data: testData)
        XCTAssertEqual(String(describing: challenge.part2()), "5905")
    }

    func test_grouped_hands_sort_part_2() throws {
        let challenge = Day07(data: testData)
        let hands: [Day07.Hand] = [
            .init(value: "QQQJA", bidAmount: 483, type: .fourOfAKind),
            .init(value: "32T3K", bidAmount: 765, type: .onePair),
            .init(value: "KTJJT", bidAmount: 220, type: .fourOfAKind),
            .init(value: "KK677", bidAmount: 28, type: .twoPair),
            .init(value: "T55J5", bidAmount: 684, type: .fourOfAKind),
        ]
        let sortedHands: [Day07.Hand] = [
            .init(value: "32T3K", bidAmount: 765, type: .onePair),
            .init(value: "KK677", bidAmount: 28, type: .twoPair),
            .init(value: "T55J5", bidAmount: 684, type: .fourOfAKind),
            .init(value: "QQQJA", bidAmount: 483, type: .fourOfAKind),
            .init(value: "KTJJT", bidAmount: 220, type: .fourOfAKind),
        ]
        let sortDictPart2 = [
            "J": 1,
            "2": 2,
            "3": 3,
            "4": 4,
            "5": 5,
            "6": 6,
            "7": 7,
            "8": 8,
            "9": 9,
            "T": 10,
            "Q": 12,
            "K": 13,
            "A": 14
        ]

        XCTAssertEqual(String(describing: challenge.groupedHandsSort(hands: hands, sortDict: sortDictPart2)), String(describing: sortedHands))
    }

    func test_decide_card_type_five_of_a_kind_part_2() throws {
        let challenge = Day07(data: testData)
        XCTAssertEqual(String(describing: challenge.decideCardType(for: "JJJJJ", isPart2: true)), "fiveOfAKind")
    }

    func test_decide_card_type_four_of_a_kind_part_2() throws {
        let challenge = Day07(data: testData)
        XCTAssertEqual(String(describing: challenge.decideCardType(for: "AA8AJ", isPart2: true)), "fourOfAKind")
    }

    func test_decide_card_type_full_house_part_2() throws {
        let challenge = Day07(data: testData)
        XCTAssertEqual(String(describing: challenge.decideCardType(for: "233J2", isPart2: true)), "fullHouse")
    }

    func test_decide_card_type_three_of_a_kind_part_2() throws {
        let challenge = Day07(data: testData)
        XCTAssertEqual(String(describing: challenge.decideCardType(for: "TTJ98", isPart2: true)), "threeOfAKind")
    }

    func test_decide_card_type_two_pair_part_2() throws {
        let challenge = Day07(data: testData)
        XCTAssertEqual(String(describing: challenge.decideCardType(for: "234J2", isPart2: true)), "threeOfAKind")
    }

    func test_decide_card_type_one_pair_part_2() throws {
        let challenge = Day07(data: testData)
        XCTAssertEqual(String(describing: challenge.decideCardType(for: "A23J4", isPart2: true)), "onePair")
    }

    func test_decide_card_type_high_card_part_2() throws {
        let challenge = Day07(data: testData)
        XCTAssertEqual(String(describing: challenge.decideCardType(for: "23456", isPart2: true)), "highCard")
    }
}

