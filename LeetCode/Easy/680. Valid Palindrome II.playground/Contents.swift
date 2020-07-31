import Foundation
import XCTest

class Solution {
  func validPalindrome(_ s: String) -> Bool {
    
    let s = [Character](s)
    var start = 0
    var end = s.count - 1
    
    while start < end {
      if s[start] == s[end] {
        start += 1
        end -= 1
      } else {
        //Checking two scenarios: Removing left or right character
        
        if (isPalindrome(s, start + 1, end)) {
          return true
        }
        
        if (isPalindrome(s, start, end - 1)) {
          return true
        }
        
        return false
      }
      
    }
    
    return true
  }
  
  private func isPalindrome(_ s: [Character], _ start: Int, _ end: Int) -> Bool {
    var start = start
    var end = end
    
    while start < end {
      if s[start] != s[end] {
        return false
      }
      
      start += 1
      end -= 1
    }
    
    return true
  }
}


class TestSolution: XCTestCase {
  var solution: Solution!
  
  override func setUp() {
    super.setUp()
    self.solution = Solution()
  }
  
  func test1() {
    let expected = false
    let actual = solution.validPalindrome("abbcbaa")
    
    XCTAssertTrue(expected == actual, "Wrong Answer")
  }
  
  func test2() {
    let expected = true
    let actual = solution.validPalindrome("racecaxr")
    
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
