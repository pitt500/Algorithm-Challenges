import Foundation
import XCTest

/*
 
 Given a sorted array A of unique numbers, find the K-th missing number starting from the leftmost number of the array.

  

 Example 1:

 Input: A = [4,7,9,10], K = 1
 Output: 5
 Explanation:
 The first missing number is 5.
 Example 2:

 Input: A = [4,7,9,10], K = 3
 Output: 8
 Explanation:
 The missing numbers are [5,6,8,...], hence the third missing number is 8.
 Example 3:

 Input: A = [1,2,4], K = 3
 Output: 6
 Explanation:
 The missing numbers are [3,5,6,7,...], hence the third missing number is 6.
 */

class Solution {
  func missingElement(_ nums: [Int], _ k: Int) -> Int {
    let firstNumber = nums[0]
    var start = 0
    var end = nums.count
    
    while start < end {
      let mid = (start + end) >> 1
      
      // mid - k check for missing numbers,
      // because nums[mid] will be greater than corresponding
      // value if all numbers were consecutive.
      if nums[mid] - mid - k >= firstNumber {
        end = mid
      } else {
        start = mid + 1
      }
    }
    
    return firstNumber + start + k - 1
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
    let expected = 8
    
    let actual = solution.missingElement([4,7,9,10], 3)
    
    XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
  }
  
  func test2() {
    let expected = 3004
    
    let actual = solution.missingElement([4], 3000)
    
    XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
  }
  
  
  func test3() {
    let expected = 6
    
    let actual = solution.missingElement([1,2,3,4,5], 1)
    
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


