import Foundation
import XCTest

/*
 Convert a non-negative integer to its english words representation.
 Given input is guaranteed to be less than 231 - 1.

 Example 1:

 Input: 123
 Output: "One Hundred Twenty Three"
 Example 2:

 Input: 12345
 Output: "Twelve Thousand Three Hundred Forty Five"
 Example 3:

 Input: 1234567
 Output: "One Million Two Hundred Thirty Four Thousand Five Hundred Sixty Seven"
 Example 4:

 Input: 1234567891
 Output: "One Billion Two Hundred Thirty Four Million Five Hundred Sixty Seven Thousand Eight Hundred Ninety One"
 
 */

class Solution {
  func numberToWords(_ num: Int) -> String {
    //Max value allowed: 2,147,483,647
    
    guard num > 19 else {
      return getUnit(num)
    }
    
    let billion = 1_000_000_000
    let million = 1_000_000
    let thousand = 1000
    
    let numBillion = num/billion
    let numMillion = (num - (numBillion*billion))/million
    let numThousand = (num - numBillion*billion - numMillion*million) / thousand
    let remaining = (num - numBillion*billion - numMillion*million - numThousand*thousand)
    
    var result = ""
    
    if numBillion > 0 {
      result += getName(numBillion) + " Billion"
    }
    
    if numMillion > 0 {
      if !result.isEmpty { result += " " }
      result += getName(numMillion) + " Million"
    }
    
    if numThousand > 0 {
      if !result.isEmpty { result += " " }
      result += getName(numThousand) + " Thousand"
    }
    
    if remaining > 0 {
      if !result.isEmpty { result += " " }
      result += getName(remaining)
    }
    
    return result
  }
  
  private func getName(_ num: Int) -> String {
    var digits = 1
    
    while digits <= num {
      digits *= 10
    }
    
    var num = num
    var result = ""
    
    while digits > 0 && num > 0 {
      num = num%digits
      
      guard num > 0 else { break }
      
      if !result.isEmpty { result += " " }
      if num < 20 {
        result.append(getUnit(num))
        break
      } else {
        result.append(getString(num))
        digits /= 10
      }
    }
    
    return result
  }
  
  private func getString(_ num: Int) -> String {
    
    
    switch num {
    case 0...19:
      return getUnit(num)
    case 20...99:
      return getTens(num/10)
    case 100...999:
      return getUnit(num/100) + " Hundred"
    default:
      return ""
    }
  }
  
  private func getUnit(_ num: Int) -> String {
    let digits = [
      "Zero",
      "One",
      "Two",
      "Three",
      "Four",
      "Five",
      "Six",
      "Seven",
      "Eight",
      "Nine",
      "Ten",
      "Eleven",
      "Twelve",
      "Thirteen",
      "Fourteen",
      "Fifteen",
      "Sixteen",
      "Seventeen",
      "Eighteen",
      "Nineteen"
    ]
    
    return digits[num]
  }
  
  private func getTens(_ num: Int) -> String {
    let tens = [
      "", "",
      "Twenty",
      "Thirty",
      "Forty",
      "Fifty",
      "Sixty",
      "Seventy",
      "Eighty",
      "Ninety"
    ]
    
    return tens[num]
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
    let expected = "One Billion Two Hundred Thirty Four Million Five Hundred Sixty Seven Thousand Eight Hundred Ninety One"
    
    let actual = solution.numberToWords(1234567891)
    
    XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
  }
  
  func test2() {
    let expected = "Two Billion One Hundred Forty Seven Million Four Hundred Eighty Three Thousand Six Hundred Forty Seven"
    
    let actual = solution.numberToWords(2_147_483_647)
    
    XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
  }
  
  func test3() {
    let expected = "One Million Two Hundred Thirty Four Thousand Five Hundred Sixty Seven"
    
    let actual = solution.numberToWords(1234567)
    
    XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
  }
  
  func test4() {
    let expected = "Zero"
    
    let actual = solution.numberToWords(0)
    
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


