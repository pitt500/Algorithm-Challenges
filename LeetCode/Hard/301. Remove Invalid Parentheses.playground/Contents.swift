import Foundation
import XCTest

/*
 Remove the minimum number of invalid parentheses in order to make the input string valid. Return all possible results.

 Note: The input string may contain letters other than the parentheses ( and ).

 Example 1:

 Input: "()())()"
 Output: ["()()()", "(())()"]
 Example 2:

 Input: "(a)())()"
 Output: ["(a)()()", "(a())()"]
 Example 3:

 Input: ")("
 Output: [""]
 
 */

class Solution {
  private let signs: Set<Character> = ["+", "-"]
  
  func isNumber(_ s: String) -> Bool {
    let s = Array(s.trimmingCharacters(in: .whitespaces))
    var eFound = false
    var atLeastOneNumber = false
    var dotFound = false
    
    for i in 0..<s.count {
      let c = s[i]
      
      if c.isNumber {
        atLeastOneNumber = true
      } else if c == "e" {
        if eFound || !atLeastOneNumber {
          return false //e can't appears without at least one number
        }
        
        eFound = true
        atLeastOneNumber = false // reset to find an integer after e
      } else if c == "." {
        if eFound || dotFound {
          return false // . can only appear once before e
        }
        
        dotFound = true
      } else if signs.contains(c) {
        if i != 0 && s[i-1] != "e" {
          return false // signs can appear onlt at i == 0 or right after e
        }
      } else {
        return false
      }
    }
    
    return atLeastOneNumber
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
    let expected = true
    let actual = solution.isNumber("1234545")
    
    XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
  }
  
  func test2() {
    let expected = false
    let actual = solution.isNumber(".1.")
    
    XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
  }
  
  func test3() {
    let expected = true
    let actual = solution.isNumber("+1234545e123")
    
    XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
  }
  
  func test4() {
    let expected = false
    let actual = solution.isNumber("+e123")
    
    XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
  }
  
  func test5() {
    let expected = false
    let actual = solution.isNumber("-123e32.1")
    
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




