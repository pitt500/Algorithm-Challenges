import Foundation
import XCTest

/*
 Given a string, find the length of the longest substring T that contains at most k distinct characters.

 Example 1:
 Input: s = "eceba", k = 2
 Output: 3
 Explanation: T is "ece" which its length is 3.
 
 Example 2:
 Input: s = "aa", k = 1
 Output: 2
 Explanation: T is "aa" which its length is 2.
 
 */

class Solution {
  func lengthOfLongestSubstringKDistinct(_ s: String, _ k: Int) -> Int {
    guard k > 0 else {
      return 0
    }
    
    let s = Array(s)
    var count = 0
    var start = 0
    var end = 0
    var letters = [Character: Int]()
    
    while end < s.count {
      if letters[s[end]] != nil || letters.keys.count < k {
        letters[s[end], default: 0] += 1
        count = max(count, end - start + 1)
        end += 1
      } else {
        letters[s[start], default: 0] -= 1
        if letters[s[start]] == 0 {
          letters.removeValue(forKey: s[start])
        }
        start += 1
      }
    }
    
    return count
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
    let expected = 5
    let actual = solution.lengthOfLongestSubstringKDistinct("losmasacuatas", 3)
    
    XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
  }
  
  func test2() {
    let expected = 3
    let actual = solution.lengthOfLongestSubstringKDistinct("eceba", 2)
    
    XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
  }
  
  func test3() {
    let expected = 10
    let actual = solution.lengthOfLongestSubstringKDistinct("aaaaaaaaaxaaaaaaaaaa", 1)
    
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




