import Foundation
import XCTest

/*
 Given a string, we can "shift" each of its letter to its successive letter,
 for example: "abc" -> "bcd". We can keep "shifting" which forms the sequence:

 "abc" -> "bcd" -> ... -> "xyz"
 Given a list of non-empty strings which contains only lowercase alphabets,
 group all strings that belong to the same shifting sequence.

 Example:

 Input: ["abc", "bcd", "acef", "xyz", "az", "ba", "a", "z"],
 Output:
 [
   ["abc","bcd","xyz"],
   ["az","ba"],
   ["acef"],
   ["a","z"]
 ]
 
 */

class Solution {
  func groupStrings(_ strings: [String]) -> [[String]] {
    var result: [String: [String]] = [:]
    
    for word in strings {
      groupHelper(word, &result)
    }
    
    return result.map { $0.value }
  }
  
  private func groupHelper(_ word: String, _ result: inout [String: [String]]) {
    
    var key = ""
    let letters = Array(word)
    let alphabetCount = 26
    
    for i in 1..<letters.count {
      var diff = letters[i].asciiVal - letters[i-1].asciiVal
      
      //Reverse order case
      // Also fix issue when we found cases like "az" when pattern is not obvious
      // But it turns out that we are in reverse, and "a" is the end of alphabet
      if diff < 0 {
        diff += alphabetCount
      }
      
      // Create key when all similar will be allocated
      // diff%alphabetCount gets the shift pattern
      key.append("\(diff%alphabetCount)")
    }
    
    result[key, default: []].append(word)
  }
}

extension Character {
    var asciiVal: Int {
        return Int(self.asciiValue!)
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
    let expected = [["baz", "zyx"], ["xyz"]]
    
    let actual = solution.groupStrings(["xyz", "zyx", "baz"])
      .map({ $0.sorted(by: <) })
      .sorted(by: { $0[0] < $1[0] })
    
    XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
  }
  
  func test2() {
    let expected = [["a", "z"], ["aabb", "bbcc"], ["abb"], ["abc", "bcd", "xyz"], ["acef"], ["az", "ba"], ["zyx"]]
    
    let actual = solution.groupStrings(["abc", "bcd", "acef", "xyz", "az", "ba", "a", "z", "aabb", "bbcc", "abb", "zyx"])
      .map({ $0.sorted(by: <) })
      .sorted(by: { $0[0] < $1[0] })
    
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


