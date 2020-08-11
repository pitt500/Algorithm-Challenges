import Foundation
import XCTest

class Solution {
  func nextPermutation(_ nums: inout [Int]) {
    
    var i = nums.count - 2
    
    // Moving index to find first decreasing number
    while i >= 0 && nums[i + 1] <= nums[i] {
      i -= 1
    }
    
    // If i is valid, find first number greater than nums[i]
    if i >= 0 {
      var j = nums.count - 1
      
      while j >= 0 && nums[j] <= nums[i] {
        j -= 1
      }
      
      if j >= 0 {
        nums.swapAt(i,j)
      }
    }
    
    //Always compute reverse from last i position + 1
    reverse(&nums, i + 1)
  }
  
  func reverse(_ nums: inout [Int], _ start: Int) {
    var start = start
    var end = nums.count - 1
    while start < end {
      nums.swapAt(start,end)
      start += 1
      end -= 1
    }
  }
}


//MARK: - Tests

class TestSolution: XCTestCase {
  var solution: Solution!
  
  override func setUp() {
    super.setUp()
    self.solution = Solution()
  }
  
  func test1() {
    var actual = [3,5,2,7,9,6,3,2]
    let expected = [3,5,2,9,2,3,6,7]
    solution.nextPermutation(&actual)
    
    XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
  }
  
  func test2() {
    var actual = [1,1]
    let expected = [1,1]
    solution.nextPermutation(&actual)
    
    XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
  }
  
  func test3() {
    var actual = [5,1,1,1]
    let expected = [1,1,1,5]
    solution.nextPermutation(&actual)
    
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

