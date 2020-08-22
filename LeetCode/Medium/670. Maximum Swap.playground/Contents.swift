import Foundation
import XCTest

/*
 
 Given a non-negative integer, you could swap two digits at most once to get the maximum valued number.
 Return the maximum valued number you could get.

 Example 1:
 Input: 2736
 Output: 7236
 Explanation: Swap the number 2 and the number 7.
 
 Example 2:
 Input: 9973
 Output: 9973
 Explanation: No swap.
 
 */

class Solution {
  func maximumSwap(_ num: Int) -> Int {
    var array = convertToArray(num)
    
    if isMaxValue(array) {
      return num
    }
    
    var right = findRightIndex(array)
    let left = findLeftIndex(array, right)
    
    if array[left] <= array[right] {
      makeRightSmaller(array, left, &right)
    }
    
    if array[left] > array[right] {
      array.swapAt(left, right)
    }
    
    let result = convertToNumber(array)
    return result
  }
  
  //Checking if num is already the max value possible
  //If it's the case, nothing else is done
  private func isMaxValue(_ array: [Int]) -> Bool {
    var maxVal = Int.min
    
    for digit in array {
      if digit >= maxVal {
        maxVal = digit
      } else {
        return false
      }
    }
    
    return true
  }
  
  private func makeRightSmaller(_ array: [Int],_ left: Int,_ right: inout Int) {
    //This fix cases like this: 98368
    // Where left and right, values are 8 & 8
    // Decreasing right until find a number smaller than array[left]
    while right > 0 && array[left] <= array[right] {
      right -= 1
    }
  }
  
  private func findRightIndex(_ array: [Int]) -> Int {
    let lastIndex = array.count - 1
    var maxIndex = lastIndex
    var maxValue = array[lastIndex]
    
    for i in stride(from: maxIndex, to: -1, by: -1) where maxValue < array[i] {
      maxValue = array[i]
      maxIndex = i
    }
    
    //If last index still the max one, we decrease it until get a number different than maxValue
    if maxIndex == lastIndex {
      
      while maxIndex > 1 && array[maxIndex] == maxValue {
        maxIndex -= 1
      }
      
      return maxIndex
    }
    
    // Last index is not the big one, the change can be done with default last index.
    return lastIndex
  }
  
  private func findLeftIndex(_ array: [Int], _ limit: Int) -> Int {
    var maxValue = array[0]
    var maxIndex = 0
    
    // Simply get max number until limit (right index)
    for i in 0..<limit where maxValue < array[i] {
      maxValue = array[i]
      maxIndex = i
    }
    
    return maxIndex
  }
  
  private func convertToArray(_ num: Int) -> [Int] {
    var array: [Int] = []
    var num = num
    let digit = 10
    
    while num > 0 {
      array.append(num%digit)
      num /= digit
    }
    
    return array
  }
  
  private func convertToNumber(_ array: [Int]) -> Int {
    var result = 0
    var digit = 1
    
    for n in array {
      result += n*digit
      digit *= 10
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
    let expected = 54321
    let actual = solution.maximumSwap(54321)
    XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
  }
  
  func test2() {
    let expected = 9983333321
    let actual = solution.maximumSwap(9923333381)
    XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
  }
  
  func test3() {
    let expected = 98888887
    let actual = solution.maximumSwap(98888887)
    XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
  }
  
  func test4() {
    let expected = 733336221
    let actual = solution.maximumSwap(633337221)
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


