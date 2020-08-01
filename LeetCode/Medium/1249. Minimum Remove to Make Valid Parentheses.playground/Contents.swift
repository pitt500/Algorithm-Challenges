import Foundation
import XCTest

class Solution {
  func minRemoveToMakeValid(_ s: String) -> String {
    
    var s = Array(s)
    var stack = [Int]()
    
    for i in 0..<s.count {
      switch s[i] {
      case "(":
        stack.append(i)
      case ")":
        if stack.isEmpty {
          s[i] = "-"
        } else {
          stack.popLast()
        }
      default:
        break
      }
    }
    
    //Mark Invalid parenthesis
    for value in stack {
      s[value] = "-"
    }
    
    // Filter invalid result
    return String(s).replacingOccurrences(of: "-", with: "")
    
  }
}


class TestSolution: XCTestCase {
  var solution: Solution!
  
  override func setUp() {
    super.setUp()
    self.solution = Solution()
  }
  
  func test1() {
    let expected = "lee(t(c)o)de"
    let actual = solution.minRemoveToMakeValid("lee(t(c)o)de)")
    
    XCTAssertTrue(expected == actual, "Wrong Answer")
  }
  
  func test2() {
    let expected = ""
    let actual = solution.minRemoveToMakeValid("))((")
    
    XCTAssertTrue(expected == actual, "Wrong Answer")
  }
  
  func test3() {
    let expected = "a(bc)d"
    let actual = solution.minRemoveToMakeValid("a)(bc)d))")
    
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
