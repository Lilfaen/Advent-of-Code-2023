//
//  Day05.swift
//
//
//  Created by Clemens Beck on 05.12.23.
//

import RegexBuilder

struct Day05: AdventDay {
    var data: String

    let rangesRegex = Regex {
        TryCapture {
            OneOrMore(.digit)
        } transform: { digits in
            Int(digits)
        }
        One(.whitespace)
        TryCapture {
            OneOrMore(.digit)
        } transform: { digits in
            Int(digits)
        }
        One(.whitespace)
        TryCapture {
            OneOrMore(.digit)
        } transform: { digits in
            Int(digits)
        }
    }

    func part1() -> Any {
        var lowestSoilNumber = Int.max

        let seeds = extractSeedNumbers().map {
            Seed(
                seedNumber: $0,
                soil: 0,
                fertilizer: 0,
                water: 0,
                light: 0,
                temperature: 0,
                humidity: 0,
                location: 0
            )
        }

        for seed in seeds {
            seed.soil = mapXtoY(block: "seed-to-soil", number: seed.seedNumber)
            seed.fertilizer = mapXtoY(block: "soil-to-fertilizer", number: seed.soil)
            seed.water = mapXtoY(block: "fertilizer-to-water", number: seed.fertilizer)
            seed.light = mapXtoY(block: "water-to-light", number: seed.water)
            seed.temperature = mapXtoY(block: "light-to-temperature", number: seed.light)
            seed.humidity = mapXtoY(block: "temperature-to-humidity", number: seed.temperature)
            seed.location = mapXtoY(block: "humidity-to-location", number: seed.humidity)

            if seed.location < lowestSoilNumber {
                lowestSoilNumber = seed.location
            }
        }

        return lowestSoilNumber
    }

    func extractSeedNumbers() -> [Int] {
        let blocks = data.split(separator: "\n").map { String($0) }
        var seeds: [Int] = []
        do {
            let seedsString = blocks[0].trimmingPrefix(try Regex("seeds: "))
            let seedsNumbers = seedsString.split(separator: " ").compactMap { $0 }
            for seed in seedsNumbers {
                seeds.append(Int(seed)!)
            }
        } catch { print(error.localizedDescription) }

        return seeds
    }

    func mapXtoY(block: String, number: Int) -> Int {
        let blocks = data.split(separator: "\n\n")
            .map { String($0) }
            .filter { $0.contains(block) }

        guard var seedToSoilMap = blocks.first else { return -1 }
        do {
            seedToSoilMap = String(seedToSoilMap.trimmingPrefix(try Regex("\(block) map:\n")))
        } catch { print(error.localizedDescription) }

        for line in seedToSoilMap.split(separator: "\n").map({ String($0) }) {
            if let match = line.wholeMatch(of: rangesRegex) {
                let dest = match.1
                let source = match.2
                let length = match.3

                let numberInDestRange = number - source + dest

                if source ... source + length ~= number, dest ... dest + length ~= numberInDestRange {
                    return numberInDestRange
                }
            }
        }
        return number
    }

    class Seed {
        var seedNumber: Int
        var soil: Int
        var fertilizer: Int
        var water: Int
        var light: Int
        var temperature: Int
        var humidity: Int
        var location: Int

        init(
            seedNumber: Int,
            soil: Int,
            fertilizer: Int,
            water: Int,
            light: Int,
            temperature: Int,
            humidity: Int,
            location: Int
        ) {
            self.seedNumber = seedNumber
            self.soil = soil
            self.fertilizer = fertilizer
            self.water = water
            self.light = light
            self.temperature = temperature
            self.humidity = humidity
            self.location = location
        }
    }

    // Part two with help

    func part2() async -> Any {
        let blocks = data.split(separator: "\n\n").map(String.init)

        let seeds: [Int] = blocks[0].split(separator: " ").dropFirst().map { Int($0)! }

        let maps: [AlmanacMap] = blocks.dropFirst().map { mapString in
            let rows = mapString.split(separator: "\n")
            let source = rows[0]
            let map = rows.dropFirst().map { row in
                let values = try! rangesRegex.wholeMatch(in: row)!
                let destinationStart = values.1
                let sourceStart = values.2
                let rangeLength = values.3

                return AlmanacMap.Range(destination: destinationStart, source: sourceStart, length: rangeLength)
            }
            return AlmanacMap(name: String(source), map: map)
        }

        let seedRanges = seeds.chunks(ofCount: 2).map { $0.first!..<($0.first! + $0.last!) }
        let asyncLocations = await withTaskGroup(of: [Int].self) { group in
            for seedRange in seedRanges {
                group.addTask {
                    seedRange.compactMap { seed in
                        seedLocation(seed: seed, maps: maps)
                    }
                }
            }

            var results = [Int]()
            for await list in group {
                results.append(contentsOf: list)
            }
            return results
        }

        return String(asyncLocations.min()!)
    }

    func seedLocation(seed: Int, maps: [AlmanacMap]) -> Int? {
        var value = seed
        maps.forEach { map in
            if let range = map.map.first(where: { $0.contains(value) }) {
                value = value - range.source + range.destination
            }
        }
        return value
    }

    struct AlmanacMap {
        struct Range {
            let destination: Int
            let source: Int
            let length: Int

            func contains(_ value: Int) -> Bool {
                value >= source && value < (source + length)
            }
        }

        let name: String
        let map: [Range]
    }

    // Dont

    func part2_BRUTEFORCE() -> Any {
        var lowestSoilNumber: [Int] = []

        let seeds = extractSeedRangeNumbers()

        for chunk in seeds.chunks(ofCount: 10) {
            for seed in chunk {
                let soil = mapXtoY(block: "seed-to-soil", number: seed)
                let fertilizer = mapXtoY(block: "soil-to-fertilizer", number: soil)
                let water = mapXtoY(block: "fertilizer-to-water", number: fertilizer)
                let light = mapXtoY(block: "water-to-light", number: water)
                let temperature = mapXtoY(block: "light-to-temperature", number: light)
                let humidity = mapXtoY(block: "temperature-to-humidity", number: temperature)
                let location = mapXtoY(block: "humidity-to-location", number: humidity)
                lowestSoilNumber.append(location)
            }
            print("another chunk done")
        }

        return lowestSoilNumber.min()!
    }

    func extractSeedRangeNumbers() -> [Int] {
        let blocks = data.split(separator: "\n").map { String($0) }
        var seeds: [Int] = []
        do {
            let seedsString = blocks[0].trimmingPrefix(try Regex("seeds: "))
            let seedsNumbers = seedsString.split(separator: " ").compactMap { Int($0) }

            var lastNumber: Int = -1

            for index in seedsNumbers.indices {

                guard lastNumber != -1 else {
                    lastNumber = seedsNumbers[index]
                    continue
                }
                seeds.append(contentsOf: lastNumber ..< lastNumber + seedsNumbers[index])
                lastNumber = -1
            }
        } catch { print(error.localizedDescription) }

        return seeds
    }
}
