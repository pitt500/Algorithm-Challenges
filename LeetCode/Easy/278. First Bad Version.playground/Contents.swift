import Foundation
import XCTest

/*
 
 You are a product manager and currently leading a team to develop a new product.
 Unfortunately, the latest version of your product fails the quality check.
 Since each version is developed based on the previous version, all the versions
 after a bad version are also bad.
 
 Suppose you have n versions [1, 2, ..., n] and you want to find out the first bad one,
 which causes all the following ones to be bad.
 
 You are given an API bool isBadVersion(version) which will return whether version is bad.
 Implement a function to find the first bad version. You should minimize the number of
 calls to the API.
 
 Example:
 
 Given n = 5, and version = 4 is the first bad version.
 
 call isBadVersion(3) -> false
 call isBadVersion(5) -> true
 call isBadVersion(4) -> true
 
 Then 4 is the first bad version.
 */

//MARK: - Solution
protocol VersionControl {
  func isBadVersion(_ value: Int) -> Bool
}

class Solution : VersionControl {
  func firstBadVersion(_ n: Int) -> Int {
    var start = 1
    var end = n
    var bad = -1
    
    while start != bad {
      let mid = (start + end) >> 1
      
      if isBadVersion(mid) {
        end = mid - 1
        bad = mid
      } else {
        start = mid + 1
      }
    }
    
    return bad
  }
  
  func isBadVersion(_ value: Int) -> Bool {
    //This is just a placeholder to test the solution
    // Use firstBadVersion(n:) with n >= 10
    return value >= 10
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
    let expected = 10
    let actual = solution.firstBadVersion(12)
    
    XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
  }
  
  func test2() {
    let expected = 10
    let actual = solution.firstBadVersion(10000)

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

