import Foundation
import XCTest

/*
 Given a string s and a non-empty string p, find all the start indices of p's anagrams in s.
 
 Strings consists of lowercase English letters only and the length of both strings s and p will not be larger than 20,100.
 
 The order of output does not matter.
 
 Example 1:
 
 Input:
 s: "cbaebabacd" p: "abc"
 
 Output:
 [0, 6]
 
 Explanation:
 The substring with start index = 0 is "cba", which is an anagram of "abc".
 The substring with start index = 6 is "bac", which is an anagram of "abc".
 Example 2:
 
 Input:
 s: "abab" p: "ab"
 
 Output:
 [0, 1, 2]
 
 Explanation:
 The substring with start index = 0 is "ab", which is an anagram of "ab".
 The substring with start index = 1 is "ba", which is an anagram of "ab".
 The substring with start index = 2 is "ab", which is an anagram of "ab".
 */

//MARK: - Solution
class Solution {
  func findAnagrams(_ s: String, _ p: String) -> [Int] {
    
    var dictP = [Character: Int]()
    var dictS = [Character: Int]()
    var result: [Int] = []
    let s = Array(s)
    let pCount = p.count
    
    for char in p {
      dictP[char, default: 0] += 1
    }
    
    for i in 0..<s.count {
      
      //Remove first char in the dictionary
      if i >= pCount {
        let char = s[i - pCount]
        dictS[char] = dictS[char]! > 1 ? dictS[char]! - 1 : nil
      }
      
      //Find a window of pCount letters to compare
      dictS[s[i], default: 0] += 1
      
      if dictS == dictP {
        result.append(i - pCount + 1)
      }
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
    let expected = [0,6]
    let actual = solution.findAnagrams("cbaebabacd", "abc")
    
    XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
  }
  
  func test2() {
    let expected = [6]
    let actual = solution.findAnagrams("cbaababbacd", "abbc")
    
    XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
  }
  
  func test3() {
    let expected = [0,1,2]
    let actual = solution.findAnagrams("abab", "ab")
    
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
