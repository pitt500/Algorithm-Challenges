import UIKit
import XCTest

class Solution {
    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        var index1 = m - 1
        var index2 = n - 1
        var mergedIndex = m + n - 1
        
        while index2 >= 0 {
            if index1 >= 0 && nums1[index1] > nums2[index2] {
                nums1[mergedIndex] = nums1[index1]
                index1 -= 1
            } else {
                nums1[mergedIndex] = nums2[index2]
                index2 -= 1
            }
            mergedIndex -= 1
        }
    }
}

class TestSolution: XCTestCase {
  var solution: Solution!
  
  override func setUp() {
    super.setUp()
    solution = Solution()
  }
  
  func testSortedMerge1() {
    let expected = [1,2,3,4,5,6]
    var actual = [4,0,0,0,0,0]
    solution.merge(&actual, 1, [1,2,3,5,6], 5)

    assert(expected == actual)
  }
  
  func testSortedMerge2() {
    let expected = [1,2,2,3,5,6]
    var actual = [1,2,3,0,0,0]
    solution.merge(&actual, 3, [2,5,6], 3)

    assert(expected == actual)
  }
  
  func testSortedMerge3() {
    let expected = [1]
    var actual = [0]
    solution.merge(&actual, 0, [1], 1)

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
