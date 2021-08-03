import UIKit
import XCTest

class Solution {
    func generateAbbreviations(_ word: String) -> [String] {
        var result: [String] = []

        func solution(_ abbreviation: String = "",_ currentIndex: Int = 0,_ counterAbbreviations: Int = 0) {
            var abbreviation = abbreviation

            if currentIndex == word.count {
                if counterAbbreviations > 0 { abbreviation.append(String(counterAbbreviations)) }
                result.append(abbreviation)
            } else {
                solution(abbreviation, currentIndex + 1, counterAbbreviations + 1)

                if counterAbbreviations > 0 { abbreviation.append(String(counterAbbreviations)) }

                let index = word.index(word.startIndex, offsetBy: currentIndex)
                abbreviation.append(word[index])
                solution(abbreviation, currentIndex + 1, 0)
            }
        }

        solution()

        return result
    }

}


class TestSolution: XCTestCase {
  var solution: Solution!
  
  override func setUp() {
    super.setUp()
    solution = Solution()
  }
  
  func test1() {
    let expected = ["2","1o","w1","wo"]
    let actual = solution.generateAbbreviations("wo")

    assert(expected == actual)
  }

    func test2() {
      let expected = ["3","2r","1o1","1or","w2","w1r","wo1","wor"]
      let actual = solution.generateAbbreviations("wor")

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
