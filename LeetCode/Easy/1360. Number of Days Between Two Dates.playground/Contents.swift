import UIKit
import XCTest

class Solution {
    
    func daysBetweenDates(_ date1: String, _ date2: String) -> Int {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = "yyyy-MM-dd"
        
        let myDate1 = formatter.date(from: date1)!
        let myDate2 = formatter.date(from: date2)!
        let seconds = Int(abs(myDate2.timeIntervalSince(myDate1)))
        
        return seconds/86400
    }
    
}

class TestSolution: XCTestCase {
  var solution: Solution!
  
  override func setUp() {
    super.setUp()
    solution = Solution()
  }
  
  func test1() {
    let expected = 61
    let actual = solution.daysBetweenDates("2019-12-31", "2020-03-01")

    assert(expected == actual)
  }
  
  func test2() {
    let expected = 5836
    let actual = solution.daysBetweenDates("2001-09-11", "1985-09-19")

    assert(expected == actual)
  }
  
  func test3() {
    let expected = 10728
    let actual = solution.daysBetweenDates("1989-05-31", "2018-10-14")

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
