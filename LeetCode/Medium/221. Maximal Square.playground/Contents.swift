import Foundation
import XCTest

class Solution {
  func maximalSquare(_ matrix: [[Character]]) -> Int {
    let rows = matrix.count
    guard rows > 0 else {
      return 0
    }
    
    let cols = matrix[0].count
    var cache = [[Int]](repeating: [Int](repeating: 0, count: cols + 1), count: rows + 1)
    var maxSquares = 0
    
    for i in 1...rows {
      for j in 1...cols where matrix[i - 1][j - 1] == "1" {
        //Check previous adjacent values. If all are 1, then we found a square
        /*
         cache[i-1][j-1]  cache[i-1][j]
                        \   |
         cache[i][j-1] -- cache[i][j]
         */
        cache[i][j] = min(min(cache[i][j - 1], cache[i - 1][j]), cache[i - 1][j - 1]) + 1
        maxSquares = max(maxSquares, cache[i][j])
      }
    }
    
    return maxSquares * maxSquares
  }
}

class TestSolution: XCTestCase {
  var solution: Solution!
  
  override func setUp() {
    super.setUp()
    self.solution = Solution()
  }
  
  func test1() {
    let expected = 4
    let actual = solution.maximalSquare([
      ["1","0","1","0","0"],
      ["1","0","1","1","1"],
      ["1","1","1","1","1"],
      ["1","0","0","1","0"]]
    )
    
    XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
  }
  
  func test2() {
    let expected = 1
    let actual = solution.maximalSquare([
      ["0","0","1","0","0"],
      ["1","0","1","1","0"],
      ["1","0","0","1","1"],
      ["1","0","0","1","0"]]
    )
    
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
