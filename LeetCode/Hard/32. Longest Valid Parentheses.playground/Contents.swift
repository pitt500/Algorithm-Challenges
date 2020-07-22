import Foundation
import XCTest

/*
 Given a string containing just the characters '(' and ')', find the length of the longest valid (well-formed) parentheses substring.

 Example 1:

 Input: "(()"
 Output: 2
 Explanation: The longest valid parentheses substring is "()"
 Example 2:

 Input: ")()())"
 Output: 4
 Explanation: The longest valid parentheses substring is "()()"
 */

class Solution {
  func longestValidParentheses(_ s: String) -> Int {
    guard !s.isEmpty else { return 0 }
    
    var result = 0
    let s = [Character](s)
    var stack = [-1]
    
    for i in 0..<s.count {
      if s[i] == "(" {
        stack.append(i)
      } else {
        stack.popLast()
        
        if stack.isEmpty {
          stack.append(i)
        } else {
          result = max(result, i - stack.last!)
        }
      }
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
  
  func test1() {
    let expected = 4
    let actual = solution.longestValidParentheses(")()())")
    
    assert(expected == actual)
  }
  
  func test2() {
    let expected = 6
    let actual = solution.longestValidParentheses(")()())()((((()))((")
    
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
