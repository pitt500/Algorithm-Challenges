import Foundation
import XCTest

class Solution {
  func merge(_ intervals: [[Int]]) -> [[Int]] {
    guard intervals.count > 0 else { return [] }
    
    let intervals = intervals.sorted(by: { $0[0] <= $1[0] })
    var result: [[Int]] = [intervals[0]]
    
    for i in 1..<intervals.count {
      if intervals[i][0] <= result[result.count - 1][1] {
        result[result.count - 1][1] = max(intervals[i][1], result[result.count - 1][1])
      } else {
        result.append(intervals[i])
      }
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
    let expected = [[1,6],[8,10],[15,18]]
    let actual = solution.merge([[2,6],[1,3],[8,10],[15,18]])
    
    XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
  }
  
  func test2() {
    let expected = [[1,10]]
    let actual = solution.merge([[1,10],[2,3],[4,5], [6,7],[8, 9]])
    
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
