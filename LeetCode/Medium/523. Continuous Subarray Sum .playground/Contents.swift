import Foundation
import XCTest

/*
 Given a list of non-negative numbers and a target integer k, write a function to check
 if the array has a continuous subarray of size at least 2 that sums up to a multiple of k,
 that is, sums up to n*k where n is also an integer.
 
 
 
 Example 1:
 
 Input: [23, 2, 4, 6, 7],  k=6
 Output: True
 Explanation: Because [2, 4] is a continuous subarray of size 2 and sums up to 6.
 Example 2:
 
 Input: [23, 2, 6, 4, 7],  k=6
 Output: True
 Explanation: Because [23, 2, 6, 4, 7] is an continuous subarray of size 5 and sums up to 42.
 */

//MARK: - Solution
class Solution {
  func checkSubarraySum(_ nums: [Int], _ k: Int) -> Bool {
    var sum = 0
    
    //Default case is for k = 0 and nums all zeros
    // Or first n values are the subarray sum
    var dict: [Int: Int] = [0: -1]
    
    for i in 0..<nums.count {
      sum += nums[i]
      
      // Do not check multiple of K if k is zero. Otherwise: Crash
      if k != 0 {
        sum = sum % k
      }
      
      guard let prevIndex = dict[sum] else {
        dict[sum] = i
        continue
      }
      
      
      if (i - prevIndex) > 1{
        return true
      }
    }
    
    return false
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
    let actual = solution.checkSubarraySum([23, 2, 6, 4, 7], 6)
    
    XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
  }
  
  func test2() {
    let expected = true
    let actual = solution.checkSubarraySum([0,1,0], -1)
    
    XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
  }
  
  func test3() {
    let expected = true
    let actual = solution.checkSubarraySum([23,15, 18, 7,0,0], 0)
    
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
