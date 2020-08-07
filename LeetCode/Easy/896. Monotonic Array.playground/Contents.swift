import Foundation
import XCTest

class Solution {
  func isMonotonic(_ A: [Int]) -> Bool {
    var increasing = true
    var decreasing = true
    
    for i in 1..<A.count  {
      if A[i - 1] > A[i] {
        increasing = false
      }
      
      if A[i - 1] < A[i] {
        decreasing = false
      }
    }
    
    return increasing || decreasing
  }
}

class TestSolution: XCTestCase {
  var solution: Solution!
  
  override func setUp() {
    super.setUp()
    self.solution = Solution()
  }
  
  func test1() {
    let expected = true
    let actual = solution.isMonotonic([1,2,2,3])
    
    XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
  }
  
  func test2() {
    let expected = false
    let actual = solution.isMonotonic([1,3,2])
    
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
