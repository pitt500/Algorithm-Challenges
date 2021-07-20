import UIKit
import XCTest

class Solution {
    func grayCode(_ n: Int) -> [Int] {
        if n == 1 { return [0, 1] }

        let sequence = grayCode(n - 1)
        var result = sequence

        // FYI: reversed is O(1) - https://developer.apple.com/documentation/swift/array/1690025-reversed
        for value in sequence.reversed() {
            result.append(value | 1 << (n-1))
        }

        return result
    }
}


class TestSolution: XCTestCase {
  var solution: Solution!
  
  override func setUp() {
    super.setUp()
    solution = Solution()
  }
  
  func test1_n2() {
    let expected = [0,1,3,2]
    let actual = solution.grayCode(2)

    assert(expected == actual)
  }
  
  func test2_n3() {
      let expected = [0,1,3,2,6,7,5,4]
      let actual = solution.grayCode(3)

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
