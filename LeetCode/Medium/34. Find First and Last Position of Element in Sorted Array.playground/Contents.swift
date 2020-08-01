import UIKit
import XCTest

class Solution {
  func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
    var start = 0
    var end = nums.count - 1
    var result = [-1, -1]
    
    while start <= end {
      let mid = start + (end - start)/2
      
      if nums[mid] < target {
        start = mid + 1
      } else if nums[mid] > target {
        end = mid - 1
      } else {
        result[0] = getEdgeIndex(nums, start, mid, target, true)
        
        let rightIndex = getEdgeIndex(nums, mid, end, target, false)
        result[1] = rightIndex > 0 ? rightIndex - 1 : 0
        break
      }
    }
    
    return result
  }
  
  private func getEdgeIndex(_ nums: [Int], _ start: Int, _ end: Int, _ target: Int, _ isLeftSide: Bool) -> Int {
    var start = start
    var end = end
    
    while start <= end {
      let mid = start + (end - start)/2
      
      if nums[mid] > target || (isLeftSide && target == nums[mid]) {
        end = mid - 1
      } else {
        start = mid + 1
      }
    }
    
    return start
  }
  
}

class TestSolution: XCTestCase {
  var solution: Solution!
  
  override func setUp() {
    super.setUp()
    self.solution = Solution()
  }
  
  func test1() {
    let expected = [3, 4]
    let actual = solution.searchRange([5,7,7,8,8,10], 8)
    
    XCTAssertTrue(expected == actual, "\nWrong Answer: expected is \(expected), but actual is \(actual)\n")
  }
  
  func test2() {
    let expected = [-1, -1]
    let actual = solution.searchRange([5,7,7,8,8,10], 6)
    
    XCTAssertTrue(expected == actual, "\nWrong Answer: expected is \(expected), but actual is \(actual)\n")
  }
  
  func test3() {
    let expected = [36, 37]
    let actual = solution.searchRange([5,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,8,8,10], 8)
    
    XCTAssertTrue(expected == actual, "\nWrong Answer: expected is \(expected), but actual is \(actual)\n")
  }
  
  func test4() {
    let expected = [0, 0]
    let actual = solution.searchRange([5,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,8,8,10], 5)
    
    XCTAssertTrue(expected == actual, "\nWrong Answer: expected is \(expected), but actual is \(actual)\n")
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

