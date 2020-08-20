import Foundation
import XCTest

//MARK: - Solution
class Solution {
  func myPow(_ x: Double, _ n: Int) -> Double {
    let x = n < 0 ? 1/x : x
    
    return powHelper(x,n)
  }
  
  private func powHelper(_ x: Double, _ n: Int) -> Double {
    if n == 0 {
      return 1
    }
    
    let result = powHelper(x,n/2)
    
    if n%2 != 0 {
      return result * result * x
    }
    
    return result * result
  }
}

//MARK: - Testing
class TestSolution: XCTestCase {
  var solution: Solution!
  
  override func setUp() {
    super.setUp()
    self.solution = Solution()
  }
  
  func test1() {
    let expected: Double = 10_460_353_203
    let actual = solution.myPow(3, 21)
    XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
  }
  
  func test2() {
    let expected: Double = 1.6935087808430282e-05
    let actual = solution.myPow(3, -10)
    XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
  }
  
  func testOverflow() {
    let expected = Double.infinity
    let actual = solution.myPow(2, Int.max)
    XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
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
