import Foundation
import XCTest

/*
 
 Implement a basic calculator to evaluate a simple expression string.

 The expression string contains only non-negative integers, +, -, *, / operators and empty spaces.
 The integer division should truncate toward zero.

 Example 1:

 Input: "3+2*2"
 Output: 7
 Example 2:

 Input: " 3/2 "
 Output: 1
 Example 3:

 Input: " 3+5 / 2 "
 Output: 5
 Note:

 You may assume that the given expression is always valid.
 
 */

class Solution {
  func calculate(_ s: String) -> Int {
    var num = 0
    
    //Stack to hold elements to be sum at the end
    var stack: [Int] = []
    
    //Since there aren't negative in the input, we set + as default operation in the first number
    var operation = "+"
    
    for char in s+"+" where char != " " {
      if let digit = char.wholeNumberValue {
        num = num * 10 + digit
      } else {
        switch operation {
        case "+":
          stack.append(num)
        case "-":
          stack.append(-num)
        case "*":
          stack.append(stack.removeLast() * num)
        case "/":
          stack.append(stack.removeLast() / num)
        default:
          break
        }
        num = 0
        operation = String(char)
      }
    }
    return stack.reduce(0, +)
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
    let expected = -2
    
    let actual = solution.calculate("16+31-      11*2*3+17")
    //Reference should be different
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


