import Foundation
import XCTest

class Solution {
  func findJudge(_ N: Int, _ trust: [[Int]]) -> Int {
    guard trust.count >= N - 1 else {
      return -1
    }
    
    var trustScore = [Int](repeating: 0, count: N + 1)
    
    for relation in trust {
      trustScore[relation[0]] -= 1 //People we trust
      trustScore[relation[1]] += 1 //People trusting in me
    }
    
    for i in 1...N where trustScore[i] == N - 1 {
      return i
    }
    
    return -1
  }
}

class TestSolution: XCTestCase {
  var solution: Solution!
  
  override func setUp() {
    super.setUp()
    solution = Solution()
  }
  
  func testSolution1() {
    let expected = 3
    let actual = solution.findJudge(3, [[1,3],[2,3]])
    
    XCTAssertTrue(expected == actual)
  }
  
  func testSolution2() {
    let expected = -1
    let actual = solution.findJudge(3, [[1,3],[2,3],[3,1]])
    
    XCTAssertTrue(expected == actual)
  }
  
  func testSolution3() {
    let expected = 3
    let actual = solution.findJudge(4, [[1,3],[1,4],[2,3],[2,4],[4,3]])
    
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

