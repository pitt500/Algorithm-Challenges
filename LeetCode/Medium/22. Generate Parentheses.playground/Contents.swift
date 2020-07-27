import Foundation
import XCTest

class Solution {
  func generateParenthesis(_ n: Int) -> [String] {
    var result = [String]()
    backtrack(result: &result, current: "", opened: 0, closed: 0, max: n)
    return result
  }
  
  private func backtrack(result: inout [String], current: String, opened: Int, closed: Int, max: Int) {
    if current.count == max * 2 {
      result.append(current)
      return
    }
    
    if opened < max {
      backtrack(result: &result, current: current + "(", opened: opened + 1, closed: closed, max: max)
    }
    
    if closed < opened {
      backtrack(result: &result, current: current + ")", opened: opened, closed: closed + 1, max: max)
    }
    
  }
}

class TestSolution: XCTestCase {
  var solution: Solution!
  
  override func setUp() {
    super.setUp()
    solution = Solution()
  }
  
  func testSolution1() {
    let expected = ["()"]
    let actual = solution.generateParenthesis(1)
    
    XCTAssertTrue(expected == actual)
  }
  
  func testSolution2() {
    let expected = ["(())","()()"]
    let actual = solution.generateParenthesis(2)
    
    XCTAssertTrue(expected == actual)
  }
  
  func testSolution3() {
    let expected = ["(((())))","((()()))","((())())","((()))()","(()(()))","(()()())","(()())()","(())(())","(())()()","()((()))","()(()())","()(())()","()()(())","()()()()"]
    let actual = solution.generateParenthesis(4)
    
    XCTAssertTrue(expected == actual)
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
