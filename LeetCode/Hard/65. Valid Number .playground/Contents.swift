import Foundation
import XCTest

/*
 Validate if a given string can be interpreted as a decimal number.

 Some examples:
 "0" => true
 " 0.1 " => true
 "abc" => false
 "1 a" => false
 "2e10" => true
 " -90e3   " => true
 " 1e" => false
 "e3" => false
 " 6e-1" => true
 " 99e2.5 " => false
 "53.5e93" => true
 " --6 " => false
 "-+3" => false
 "95a54e53" => false

 Note: It is intended for the problem statement to be ambiguous.
 You should gather all requirements up front before implementing one.
 However, here is a list of characters that can be in a valid decimal number:

 Numbers 0-9
 Exponent - "e"
 Positive/negative sign - "+"/"-"
 Decimal point - "."
 Of course, the context of these characters also matters in the input.
 
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



