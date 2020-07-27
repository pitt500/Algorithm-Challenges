import UIKit
import XCTest

let graph = [
  [1, 0, 0, 0, 1, 0],
  [0, 1, 0, 0, 1, 0],
  [0, 0, 1, 0, 1, 0],
  [1, 1, 1, 1, 1, 1],
  [0, 0, 0, 0, 1, 0],
  [1, 0, 0, 0, 1, 1],
]

protocol Relation {
  func knows(_ a: Int, _ b: Int) -> Bool
}

extension Relation {
  func knows(_ a: Int, _ b: Int) -> Bool {
    return graph[a][b] == 1
  }
}

class Solution: Relation {
  func findCelebrity(_ n: Int) -> Int {
    
    var candidate = 0
    for i in 0..<n {
      if knows(candidate, i) {
        candidate = i
      }
    }
    
    if isCelebrity(candidate, n) {
      return candidate
    }
    
    return -1
    
  }
  
  private func isCelebrity(_ person: Int, _ numPeople: Int) -> Bool {
    for i in 0..<numPeople where person != i  {
      if knows(person, i) || !knows(i, person) {
        return false
      }
    }
    
    return true
  }
}

class TestSolution: XCTestCase {
  var solution: Solution!
  
  override func setUp() {
    super.setUp()
    solution = Solution()
  }
  
  func testRelation() {
    let expected = 4
    let actual = solution.findCelebrity(graph.count)

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
