//
//  Day07.swift
//
//
//  Created by Clemens Beck on 07.12.23.
//

import RegexBuilder

struct Day07: AdventDay {
    var data: String

    let sortDictPart1 = ["2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, "9": 9, "T": 10, "J": 11, "Q": 12, "K": 13, "A": 14]

    let sortDictPart2 = ["J": 1, "2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, "9": 9, "T": 10, "Q": 12, "K": 13, "A": 14]

    func initializeHands(isPart2: Bool = false) -> [Hand] {
        let handRegex = Regex {
            TryCapture {
                OneOrMore(.word)
            } transform: { w in
                String(w)
            }
            One(.whitespace)
            TryCapture {
                OneOrMore(.digit)
            } transform: { d in
                Int(d)
            }
        }
            .anchorsMatchLineEndings()

        let lines = data.split(separator: "\n")
        return lines.compactMap ({ line in
            if let match = line.wholeMatch(of: handRegex) {
                return Hand(
                    value: match.1,
                    bidAmount: match.2,
                    type: decideCardType(for: match.1, isPart2: isPart2)
                )
            }
            return nil
        })
    }

    func part1() -> Any {
        var hands = initializeHands()
        hands = groupedHandsSort(hands: hands, sortDict: sortDictPart1)
        return calculateWinnings(hands: hands)
    }

    func part2() -> Any {
        var hands = initializeHands(isPart2: true)
        hands = groupedHandsSort(hands: hands, sortDict: sortDictPart2)
        return calculateWinnings(hands: hands)
    }

    struct Hand {
        let value: String
        let bidAmount: Int
        let type: CardType
    }

    enum CardType: Int, CaseIterable {
        case highCard
        case onePair
        case twoPair
        case threeOfAKind
        case fullHouse
        case fourOfAKind
        case fiveOfAKind

        case error = -1
    }

    func groupedHandsSort(hands: [Hand], sortDict: [String: Int]) -> [Hand] {
        func handsSort(hands: [Hand], sortDict: [String: Int]) -> [Hand] {
            return hands.sorted { (lhs: Hand, rhs: Hand) in
                for index in lhs.value.indices {
                    let lhsValue = String(lhs.value[index])
                    let rhsValue = String(rhs.value[index])
                    if lhs.value[index] != rhs.value[index] {
                        return sortDict[lhsValue]! < sortDict[rhsValue]!
                    }
                }
                return false
            }
        }

        var sortedHands: [Hand] = []
        for type in CardType.allCases {
            let tempHands = handsSort(hands: hands.filter { $0.type == type}, sortDict: sortDict)
            sortedHands.append(contentsOf: tempHands)
        }
        return sortedHands
    }

    func calculateWinnings(hands: [Hand]) -> Int {
        var winnings: Int = 0
        for index in hands.indices {
            winnings += hands[index].bidAmount * (index + 1)
        }
        return winnings
    }

    func decideCardType(for string: String, isPart2: Bool = false) -> CardType {
        let values = string.split(separator: "").sorted(by: <)
        var vals: [String: Int] = [:]
        values.forEach { vals[String($0), default: 0] += 1 }

        let containsOnlyOneLetter = vals.count == 1
        if isPart2, !containsOnlyOneLetter {
            let jokers = vals["J"] ?? 0
            vals.removeValue(forKey: "J")

            if let keyWithMaxValue = vals.max(by: { a, b in a.value < b.value })?.key {
                vals[keyWithMaxValue]! += jokers
            }
        }

        var uniqueNumbers = Set(values).count
        if isPart2, !containsOnlyOneLetter {
            uniqueNumbers -= Set(values.filter { $0 == "J" }).count
        }
        switch uniqueNumbers {
        case 5:
            return .highCard
        case 4:
            return .onePair
        case 3:
            if vals.values.contains(3) {
                return .threeOfAKind
            } else if vals.values.contains(2) {
                return .twoPair
            }
        case 2:
            if vals.values.contains(3) {
                return .fullHouse
            } else if vals.values.contains(4) {
                return .fourOfAKind
            }
        case 1:
            return .fiveOfAKind
        default:
            return .error
        }
        return .error
    }
}
