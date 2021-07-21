import UIKit
import XCTest

class Solution {
    func isPalindrome(_ x: Int) -> Bool {
        if x < 0 || (x%10 == 0 && x != 0) { return false }

        var reversed = 0
        var number = x

        while number > reversed {
            reversed = reversed * 10 + number % 10
            number /= 10
        }

        return number == reversed || number == reversed/10
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
    let actual = solution.isPalindrome(12221)

    assert(expected == actual)
  }

    func test2() {
      let expected = false
      let actual = solution.isPalindrome(12343)

      assert(expected == actual)
    }

    func test3() {
      let expected = false
      let actual = solution.isPalindrome(11111221111)

      assert(expected == actual)
    }

    func test4() {
      let expected = true
      let actual = solution.isPalindrome(0)

      assert(expected == actual)
    }

    func test5() {
      let expected = false
      let actual = solution.isPalindrome(10)

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
