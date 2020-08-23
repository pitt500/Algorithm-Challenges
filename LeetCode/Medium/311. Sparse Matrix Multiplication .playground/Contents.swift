import Foundation
import XCTest

/*
 
 Given two sparse matrices A and B, return the result of AB.
 
 You may assume that A's column number is equal to B's row number.
 
 Example:
 
 Input:
 
 A = [
 [ 1, 0, 0],
 [-1, 0, 3]
 ]
 
 B = [
 [ 7, 0, 0 ],
 [ 0, 0, 0 ],
 [ 0, 0, 1 ]
 ]
 
 Output:
 
 |  1 0 0 |   | 7 0 0 |   |  7 0 0 |
 AB = | -1 0 3 | x | 0 0 0 | = | -7 0 3 |
 | 0 0 1 |
 */

class Solution {
  func multiply(_ A: [[Int]], _ B: [[Int]]) -> [[Int]] {
    var result = [[Int]](repeating: [Int](repeating: 0, count: B[0].count), count: A.count)
    
    for aRow in 0..<A.count {
      for aCol in 0..<A[0].count where A[aRow][aCol] != 0 {
        for bCol in 0..<B[0].count where B[aCol][bCol] != 0 {
          result[aRow][bCol] += A[aRow][aCol] * B[aCol][bCol]
        }
      }
    }
    
    return result
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
    let A = [
      [1,0,0],
      [-1,0,3]
    ]
    
    let B = [
      [7,0,0],
      [0,0,0],
      [0,0,1]
    ]
    
    let expected = [
      [7,0,0],
      [-7,0,3]
    ]
    let actual = solution.multiply(A, B)
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



