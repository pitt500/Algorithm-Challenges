import Foundation
import XCTest

class Solution {
  func groupAnagrams(_ strs: [String]) -> [[String]] {
    return Dictionary(
      grouping: strs,
      by: { String($0.sorted()) }
    ).map { $0.value }
  }
}

class TestSolution: XCTestCase {
  var solution: Solution!
  
  override func setUp() {
    super.setUp()
    solution = Solution()
  }
  
  func testSortedMerge1() {
    let expected =  [["bat"],["nat","tan"],["ate","eat","tea"]]
    let actual = solution.groupAnagrams(["eat","tea","tan","ate","nat","bat"])
    var isCorrect = true
    
    for _ in actual where !expected.contains(where: { actual.contains($0) }) {
      isCorrect = false
      break
    }
    
    assert(isCorrect)
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
