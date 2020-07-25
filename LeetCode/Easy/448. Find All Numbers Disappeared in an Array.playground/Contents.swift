import Foundation
import XCTest

/*
 Given an array of integers where 1 ≤ a[i] ≤ n (n = size of array), some elements appear twice and others appear once.
 
 Find all the elements of [1, n] inclusive that do not appear in this array.
 
 Could you do it without extra space and in O(n) runtime? You may assume the returned list does not count as extra space.
 
 Example:
 
 Input:
 [4,3,2,7,8,2,3,1]
 
 Output:
 [5,6]
 */


class Solution {
  func findDisappearedNumbers(_ nums: [Int]) -> [Int] {
    guard !nums.isEmpty else { return [] }
    
    var nums = nums
    var result = [Int]()
    
    //Use index to mark as found using negative
    for i in 0..<nums.count {
      let index = abs(nums[i]) - 1
      
      if nums[index] > 0 {
        nums[index] *= -1
      }
    }
    
    //Get all positives = missing in the array from 1 to n
    for i in 1...nums.count where nums[i - 1] > 0{
      result.append(i)
    }
    
    return result
  }
}


class TestSolution: XCTestCase {
  var solution: Solution!
  
  override func setUp() {
    super.setUp()
    self.solution = Solution()
  }
  
  func test1() {
    let expected = [5,6]
    let actual = solution.findDisappearedNumbers([4,3,2,7,8,2,3,1])
    
    XCTAssertTrue(expected == actual, "Wrong Answer")
  }
  
  func test2() {
    let expected = [Int]()
    let actual = solution.findDisappearedNumbers([4,3,2,7,8,5,6,1])
    
    XCTAssertTrue(expected == actual, "Wrong Answer")
  }
  
  
  func test3() {
    let expected = [3, 4, 5]
    let actual = solution.findDisappearedNumbers([1, 7, 9, 1, 7, 8, 2, 6, 2])
    
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
