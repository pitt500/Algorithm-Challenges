import Foundation
import XCTest

/*
 Given a set of distinct integers, nums, return all possible subsets (the power set).

 Note: The solution set must not contain duplicate subsets.

 Example:

 Input: nums = [1,2,3]
 Output:
 [
   [3],
   [1],
   [2],
   [1,2,3],
   [1,3],
   [2,3],
   [1,2],
   []
 ]
 */
class Solution {
    func subsets(_ nums: [Int]) -> [[Int]] {
        guard nums.count > 0 else {
            return [[]]
        }
        
        var nums = nums
        let last = nums.removeLast()
        
        let prevResult = subsets(nums)
        var result = prevResult
        
        for prev in prevResult {
            result.append(prev + [last])
        }
        
        return result
    }
}

class TestSolution: XCTestCase {
  var solution: Solution!
  
  override func setUp() {
    super.setUp()
    solution = Solution()
  }
  
  func testSolution1() {
    let expected = [[],[1],[2],[1,2],[3],[1,3],[2,3],[1,2,3]]
    let actual = solution.subsets([1, 2, 3])
    
    XCTAssertTrue(expected == actual)
  }
  
  func testSolution2() {
    let expected = [[],[1],[2],[1,2],[3],[1,3],[2,3],[1,2,3],[4],[1,4],[2,4],[1,2,4],[3,4],[1,3,4],[2,3,4],[1,2,3,4]]
    let actual = solution.subsets([1,2,3,4])
    
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
