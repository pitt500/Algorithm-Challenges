import UIKit
import XCTest

class Solution {
    func isPalindrome(_ s: String) -> Bool {
        let word = s.filter { $0.isNumber || $0.isLetter }.lowercased()
        if word.isEmpty { return true }

        var startIndex = word.startIndex
        var endIndex = word.index(before: word.endIndex)

        while startIndex < endIndex {
            guard word[startIndex] == word[endIndex]
            else {
                return false
            }

            startIndex = word.index(after: startIndex)
            endIndex = word.index(before: endIndex)
        }

        return true
    }
}

class TestSolution: XCTestCase {
  var solution: Solution!
  
  override func setUp() {
    super.setUp()
    solution = Solution()
  }
  
  func test1() {
    let expected = true
    let actual = solution.isPalindrome("A man, a plan, a canal: Panama")

    assert(expected == actual)
  }

    func test2() {
      let expected = false
      let actual = solution.isPalindrome("race a car")

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
