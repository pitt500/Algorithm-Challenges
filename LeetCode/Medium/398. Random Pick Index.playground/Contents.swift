import Foundation
import XCTest

/*
 Given an array of integers with possible duplicates, randomly output the
 index of a given target number. You can assume that the given target
 number must exist in the array.
 
 Note:
 The array size can be very large. Solution that uses too much extra
 space will not pass the judge.
 
 Example:
 
 int[] nums = new int[] {1,2,3,3,3};
 Solution solution = new Solution(nums);
 
 // pick(3) should return either index 2, 3, or 4 randomly. Each index should have equal probability of returning.
 solution.pick(3);
 
 // pick(1) should return 0. Since in the array only nums[0] is equal to 1.
 solution.pick(1);
 */

//MARK: - Solution
class Solution {
  private var dict: [Int: [Int]] = [:]
  
  init(_ nums: [Int]) {
    setupDictionary(nums)
  }
  
  func pick(_ target: Int) -> Int {
    return dict[target]!.randomElement()!
  }
  
  private func setupDictionary(_ nums: [Int]) {
    for (i,n) in nums.enumerated(){
      dict[n, default: []].append(i)
    }
  }
}


//MARK: - Testing
class TestSolution: XCTestCase {

  func test1() {
    let solution = Solution([1,2,3,3,3,4,4,5])
    let expected = Set<Int>([2,3,4])
    let actual = solution.pick(3)
    
    XCTAssertTrue(expected.contains(actual), "\nexpected value is \(expected), but actual is \(actual)\n")
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

