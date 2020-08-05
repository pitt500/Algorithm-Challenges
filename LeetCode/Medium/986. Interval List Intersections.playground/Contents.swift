import Foundation
import XCTest

class Solution {
  func intervalIntersection(_ A: [[Int]], _ B: [[Int]]) -> [[Int]] {
    guard !A.isEmpty, !B.isEmpty else { return [] }
    
    var i = 0
    var j = 0
    var result: [[Int]] = []
    
    while i < A.count && j < B.count {
      let maxStart = max(A[i][0],B[j][0])
      let minEnd = min(A[i][1],B[j][1])
      
      if maxStart <= minEnd {
        result.append([maxStart, minEnd])
      }
      
      if minEnd == A[i][1] {
        i += 1
      } else {
        j += 1
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
    let expected = [[1,2],[5,5],[8,10],[15,23],[24,24],[25,25]]
    let actual = solution.intervalIntersection([[0,2],[5,10],[13,23],[24,25]], [[1,5],[8,12],[15,24],[25,26]])
    
    XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
  }
  
  func test2() {
    let expected: [[Int]] = []
    let actual = solution.intervalIntersection([], [[1,5],[8,12],[15,24],[25,26]])
    
    XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
  }
  
  func test3() {
    let expected = [[5, 5], [8, 10], [21, 23], [24, 24], [25, 25]]
    let actual = solution.intervalIntersection([[0,2],[5,10],[21,23],[24,25]], [[3,5],[8,12],[15,24],[25,26]])
    
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
