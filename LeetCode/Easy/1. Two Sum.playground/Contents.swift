import UIKit
import XCTest

class Solution {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var cache: [Int: Int] = [:]

        for (index, num) in nums.enumerated() {
            let key = target - num

            if let prevIndex = cache[key] {
                return [prevIndex, index]
            }

            cache[num] = index
        }

        return []
    }
}

/*
1. Create a key = target - nums[i]
2. Find if dict is not empty
    - If not, then return [prevIndex, index] as the result
3. Create a new dictionary value equal to index (current index)
4. do this nums.count times

Note: Consider negative numbers
*/

class TestSolution: XCTestCase {
  var solution: Solution!
  
  override func setUp() {
    super.setUp()
    solution = Solution()
  }
  
  func test1() {
    let expected = [0, 1]
    let actual = solution.twoSum([2, 7, 11, 15], 9)

    print(expected, actual)
    assert(expected == actual)
  }

    func test2() {
      let expected = [1, 2]
        let actual = solution.twoSum([3, 2, 4], 6)

      assert(expected == actual)
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
