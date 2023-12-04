//
//  Day04.swift
//
//
//  Created by Clemens Beck on 04.12.23.
//

struct Day04: AdventDay {
    var data: String

    func part1() -> Any {
        var points: Int = 0

        let lines = data.split(separator: "\n").map { String($0) }
        for line in lines {
            let matches = getWinningNumbers(card: line)
            var cardPoints = 0.5
            for _ in matches {
                cardPoints = cardPoints * 2
            }
            points += Int(cardPoints)
        }

        return points
    }

    func getWinningNumbers(card: String) -> [Int] {
        var winningNumberMatches: [Int] = []

        do {
            let string = card.trimmingPrefix(try Regex("Card [0-9]: "))

            let split = string.split(separator: " | ")
            let winningNumbers = split[0].split(separator: " ").map { Int($0) }
            let numbers = split[1].split(separator: " ").map { Int($0) }

            let matches = numbers.filter { int in
                winningNumbers.contains(int)
            }
            winningNumberMatches = matches.compactMap { $0 }
        } catch {
            print(error.localizedDescription)
        }

        return winningNumberMatches
    }

    func part2() -> Any {
        class Card {
            var string: String
            var winningNumbers: Int
            var occurrences: Int

            init(
                string: String,
                winningNumbers: Int,
                occurrences: Int
            ) {
                self.string = string
                self.winningNumbers = winningNumbers
                self.occurrences = occurrences
            }
        }

        let allCards = data.split(separator: "\n").map {
            Card.init(
                string: String($0),
                winningNumbers: getWinningNumbers(card: String($0)).count,
                occurrences: 1
            )
        }

        for index in allCards.indices {
            let card = allCards[index]
            for i in 0 ..< card.winningNumbers {
                
                let nextCardIndex = index + i + 1

                if nextCardIndex < allCards.count {
                    let nextCard = allCards[nextCardIndex]
                    print(index, card.occurrences, nextCard.occurrences)
                    nextCard.occurrences += card.occurrences
                }
            }
        }

        return allCards.map { $0.occurrences }.reduce(0, +)
    }
}
