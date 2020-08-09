import Foundation
import XCTest

class Solution {
  func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
    // Naive solution:
    //return nums.sorted(by: >)[k - 1]
    //Other alternative: Heap
    
    var nums = nums
    var start = 0
    var end = nums.count - 1
    
    let index = nums.count - k
    while start <= end {
      let pivotIndex = partition(start, end, &nums)
      
      if pivotIndex == index {
        return nums[pivotIndex]
      } else if pivotIndex < index {
        start = pivotIndex + 1
      } else {
        end = pivotIndex - 1
      }
    }
    
    return -1
  }
  
  func partition(_ start: Int, _ end: Int, _ nums: inout [Int]) -> Int {
    let index = start
    let pivot = nums[start]
    var start = start
    var end = end
    
    // sort elements compared to pivot
    while start <= end {
      while start <= end && nums[start] <= pivot {
        start += 1
      }
      
      while start <= end && nums[end] >= pivot {
        end -= 1
      }
      
      if start <= end {
        nums.swapAt(start, end)
        start += 1
        end -= 1
      }
    }
    
    //Move pivot to final place
    nums.swapAt(index, end)
    
    return end
  }
}

class TestSolution: XCTestCase {
  var solution: Solution!
  
  override func setUp() {
    super.setUp()
    self.solution = Solution()
  }
  
  func test1() {
    let expected = 4
    let actual = solution.findKthLargest([3,2,3,1,2,4,5,5,6], 4)
    
    XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
  }
  
  func test2() {
    let expected = 5
    let actual = solution.findKthLargest([3,2,1,5,6,4], 2)
    
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
