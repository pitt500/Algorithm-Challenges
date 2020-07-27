import Foundation
import XCTest

class Solution {
  func search(_ nums: [Int], _ target: Int) -> Int {
    var start = 0
    var end = nums.count - 1
    
    while start <= end {
      let mid = start + (end - start)/2
      
      if nums[mid] == target {
        return mid
      }
      
      if nums[mid] >= nums[start] {
        if target >= nums[start] && target < nums[mid] {
          end = mid - 1
        } else {
          start = mid + 1
        }
      } else {
        if target > nums[mid] && target <= nums[end] {
          start = mid + 1
        } else {
          end = mid - 1
        }
      }
    }
    
    return -1
  }
}


class TestSolution: XCTestCase {
  var solution: Solution!
  
  override func setUp() {
    super.setUp()
    solution = Solution()
  }
  
  func testSolution1() {
    let expected = -1
    let actual = solution.search([4,5,6,7,0,1,2], 3)
    
    XCTAssertTrue(expected == actual)
  }
  
  func testSolution2() {
    let expected = 4
    let actual = solution.search([4,5,6,7,0,1,2], 0)
    
    XCTAssertTrue(expected == actual)
  }
  
  func testSolution3() {
    let expected = 6
    let actual = solution.search([4,5,6,7,8,9,2], 2)
    
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
