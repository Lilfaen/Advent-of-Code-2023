//
//  Day01.swift
//  
//
//  Created by Clemens Beck on 01.12.23.
//

import Algorithms
import Foundation
import RegexBuilder

struct Day01: AdventDay {
    var data: String

    func part1() -> Any {
        var sum = 0

        let lines = data.split(separator:"\n")
        for line in lines {
            let numbers = line.replacingOccurrences(of: "[a-z]", with: "", options: .regularExpression, range: nil)

            if let firstDigit = (numbers.first.map { String($0) }),
               let lastDigit = (numbers.last.map { String($0) }) {

                let numberString: String = firstDigit + lastDigit

                let number = Int(numberString) ?? 0

                sum += number
            }
        }

        return sum
    }

    func part2() -> Any {
        let firstDigitMatch = Regex {
            Capture {
                ChoiceOf {
                    "one"
                    "two"
                    "three"
                    "four"
                    "five"
                    "six"
                    "seven"
                    "eight"
                    "nine"
                    "zero"
                    One(.digit)
                }
            }
        }

        let lastDigitMatch = Regex {
            ZeroOrMore(.whitespace.inverted)
            Capture {
                ChoiceOf {
                    "one"
                    "two"
                    "three"
                    "four"
                    "five"
                    "six"
                    "seven"
                    "eight"
                    "nine"
                    "zero"
                    One(.digit)
                }
            }
            ZeroOrMore(.whitespace.inverted)
            Anchor.endOfLine
        }
        var sum = 0

        let lines = data.split(separator:"\n")
        for line in lines {
            var firstDigit: String = ""

            if let match = line.firstMatch(of: firstDigitMatch) {
                firstDigit = String(match.1)
            }

            var lastDigit: String = ""

            if let match = line.wholeMatch(of: lastDigitMatch) {
                lastDigit = String(match.1)
            }

            let combined = "\(firstDigit.wordToInteger()!)\(lastDigit.wordToInteger()!)"

            sum += Int(combined)!
        }

        return sum
    }
}

fileprivate extension String {
    func wordToInteger() -> Int? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .spellOut
        return Int(self) ?? numberFormatter.number(from: self) as? Int
    }
}
