import Foundation
import XCTest

class Solution {
  func minAddToMakeValid(_ S: String) -> Int {
    var result = 0
    var count = 0
    
    for char in S {
      if char == "(" {
        count += 1
      } else if count == 0 {
        // No more balanced
        result += 1
      } else {
        count -= 1
      }
    }
    
    return result + count
  }
}

class TestSolution: XCTestCase {
  var solution: Solution!
  
  override func setUp() {
    super.setUp()
    self.solution = Solution()
  }
  
  func test1() {
    let expected = 4
    let actual = solution.minAddToMakeValid("()))((")
    
    XCTAssertTrue(expected == actual, "Wrong Answer")
  }
  
  func test2() {
    let expected = 3
    let actual = solution.minAddToMakeValid("(((")
    
    XCTAssertTrue(expected == actual, "Wrong Answer")
  }
  
  func test3() {
    let expected = 0
    let actual = solution.minAddToMakeValid("((()))")
    
    XCTAssertTrue(expected == actual, "Wrong Answer")
  }
  
  func test4() {
    let expected = 4
    let actual = solution.minAddToMakeValid("))((")
    
    XCTAssertTrue(expected == actual, "Wrong Answer")
  }
  
  func test5() {
    let expected = 7
    let actual = solution.minAddToMakeValid("()()(((()()(((((((()))))(((()))")
    
    XCTAssertTrue(expected == actual, "Wrong Answer")
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
