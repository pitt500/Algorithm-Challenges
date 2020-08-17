import Foundation
import XCTest

/*
 Given a nested list of integers, return the sum of all integers in the list weighted by their depth.

 Each element is either an integer, or a list -- whose elements may also be integers or other lists.

 Example 1:

 Input: [[1,1],2,[1,1]]
 Output: 10
 Explanation: Four 1's at depth 2, one 2 at depth 1.
 Example 2:

 Input: [1,[4,[6]]]
 Output: 27
 Explanation: One 1 at depth 1, one 4 at depth 2, and one 6 at depth 3; 1 + 4*2 + 6*3 = 27.
 */

//MARK: - Helper
class NestedInteger {
  private var items: [NestedInteger] = []
  private var value: Int?
  
  init(items: [Int]) {
    self.items = items.map {
      NestedInteger(value: $0)
    }
  }
  
  init(value: Int) {
    self.value = value
  }
  
  func isInteger() -> Bool {
    value != nil
  }
  
  func getInteger() -> Int {
    if isInteger() {
      return value!
    }
    
    return Int.min
  }
  
  func getList() -> [NestedInteger] {
    items
  }
  
}

//MARK: - Solution
class Solution {
  func depthSum(_ nestedList: [NestedInteger], _ depth: Int = 1) -> Int {
    var counter = 0
    
    for n in nestedList {
      if n.isInteger() {
        counter += n.getInteger() * depth
      } else {
        counter += depthSum(n.getList(), depth + 1)
      }
    }
    
    return counter
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
    let list: [NestedInteger] = [
      NestedInteger(items: [1,1]),
      NestedInteger(value: 2),
      NestedInteger(items: [1,1])
    ]
    
    let expected = 10
    let actual = solution.depthSum(list)
    
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

