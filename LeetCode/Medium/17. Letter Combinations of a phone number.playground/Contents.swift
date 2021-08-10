import UIKit
import XCTest

class Solution {
    func letterCombinations(_ digits: String) -> [String] {
        if digits.isEmpty { return [] }

        return helper(digits)
    }

    private func helper(_ digits: String) -> [String] {
        var digits = digits

        guard let digit = digits.popLast() else {
            return [""]
        }

        var combinations = helper(digits)
        let letters = letters(from: digit)
        var newCombination: [String] = []

        for item in combinations {
            for letter in letters {
                newCombination.append(item + letter)
            }
        }

        return newCombination
    }

    private func letters(from digit: Character) -> [String] {
        switch digit {
        case "2":
            return ["a", "b", "c"]
        case "3":
            return ["d", "e", "f"]
        case "4":
            return ["g", "h", "i"]
        case "5":
            return ["j", "k", "l"]
        case "6":
            return ["m", "n", "o"]
        case "7":
            return ["p", "q", "r", "s"]
        case "8":
            return ["t", "u", "v"]
        case "9":
            return ["w", "x", "y", "z"]
        default:
            return []
        }
    }
}


class TestSolution: XCTestCase {
    var solution: Solution!

    override func setUp() {
        super.setUp()
        solution = Solution()
    }

    func test1() {
        let expected = ["ad","ae","af","bd","be","bf","cd","ce","cf"]
        let actual = solution.letterCombinations("23")

        assert(expected == actual)
    }

    func test2() {
        let expected = ["www","wwx","wwy","wwz","wxw","wxx","wxy","wxz","wyw","wyx","wyy","wyz","wzw","wzx","wzy","wzz","xww","xwx","xwy","xwz","xxw","xxx","xxy","xxz","xyw","xyx","xyy","xyz","xzw","xzx","xzy","xzz","yww","ywx","ywy","ywz","yxw","yxx","yxy","yxz","yyw","yyx","yyy","yyz","yzw","yzx","yzy","yzz","zww","zwx","zwy","zwz","zxw","zxx","zxy","zxz","zyw","zyx","zyy","zyz","zzw","zzx","zzy","zzz"]
        let actual = solution.letterCombinations("999")

        assert(expected == actual)
    }

    func test3() {
        let expected: [String] = []
        let actual = solution.letterCombinations("")

        assert(expected == actual)
    }
}

class TestObserver: NSObject, XCTestObservation {
    func testCase(_ testCase: XCTestCase,
                  didFailWithDescription description: String,
                  inFile filePath: String?,
                  atLine lineNumber: Int) {
        assertionFailure(description, line: UInt(lineNumber))
    }
}

let testObserver = TestObserver()
XCTestObservationCenter.shared.addTestObserver(testObserver)
TestSolution.defaultTestSuite.run()
