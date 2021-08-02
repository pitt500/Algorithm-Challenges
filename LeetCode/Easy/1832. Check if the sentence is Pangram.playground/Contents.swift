import UIKit
import XCTest

class Solution {
    func checkIfPangram(_ sentence: String) -> Bool {
        var alphabet = Set<Character>("abcdefghijklmnopqrstuvwxyz")

        for letter in sentence where alphabet.contains(letter) {
            alphabet.remove(letter)
        }

        return alphabet.isEmpty
    }
}

// 1. Declare a set (alphabet) with all the alphabet
// 2. Interate over all sentence
// 3. If a letter is contained in the set, remove it.
// 4. Return alphabet.isEmpty

class TestSolution: XCTestCase {
  var solution: Solution!
  
  override func setUp() {
    super.setUp()
    solution = Solution()
  }
  
  func test1() {
    let expected = true
    let actual = solution.checkIfPangram("thequickbrownfoxjumpsoverthelazydog")

    assert(expected == actual)
  }

    func test2() {
      let expected = false
      let actual = solution.checkIfPangram("leetcode")

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
