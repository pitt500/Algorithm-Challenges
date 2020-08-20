import Foundation
import XCTest

//MARK: - Solution
class Solution {
  
  func divide(_ dividend: Int, _ divisor: Int) -> Int {
    let isNegative = (dividend < 0) != (divisor < 0)
    
    var dividend = abs(dividend)
    let divisor = abs(divisor)
    
    guard divisor > 1 else {
      return valid(dividend, isNegative)
    }
    
    var maxValue = divisor
    var maxPow = 1
    var count = 0
    
    // Get max power of two that is less or equal original dividend
    while (maxValue << 1) <= dividend {
      maxValue <<= 1
      maxPow <<= 1
    }
    
    // With maxValue, add maxPow to count (result)
    // Then substract from dividend until maxValue greater than current dividend
    while divisor <= dividend {
      if maxValue <= dividend {
        count += maxPow
        dividend -= maxValue
      }
      
      maxPow >>= 1
      maxValue >>= 1
    }
    
    return valid(count, isNegative)
  }
  
  //Check overflow
  private func valid(_ value: Int, _ isNegative: Bool) -> Int {
    var result = value
    if isNegative {
      let min = Int(Int32.min)
      result = -value < min ? min : -value
    } else {
      let max = Int(Int32.max)
      result = value > max ? max : value
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
    let expected = 7
    let actual = solution.divide(23, 3)
    XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
  }
  
  func test2() {
    let expected = 596
    let actual = solution.divide(93706, 157)
    XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
  }
  
  func testOverflow() {
    let expected = Int32.max
    let actual = solution.divide(-2147483648, -1)
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

