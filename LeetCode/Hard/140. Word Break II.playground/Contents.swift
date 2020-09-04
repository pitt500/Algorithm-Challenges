import Foundation
import XCTest

/*
 Given a non-empty string s and a dictionary wordDict containing a list of non-empty words,
 add spaces in s to construct a sentence where each word is a valid dictionary word.
 Return all such possible sentences.

 Note:

 The same word in the dictionary may be reused multiple times in the segmentation.
 You may assume the dictionary does not contain duplicate words.
 Example 1:

 Input:
 s = "catsanddog"
 wordDict = ["cat", "cats", "and", "sand", "dog"]
 Output:
 [
   "cats and dog",
   "cat sand dog"
 ]
 Example 2:

 Input:
 s = "pineapplepenapple"
 wordDict = ["apple", "pen", "applepen", "pine", "pineapple"]
 Output:
 [
   "pine apple pen apple",
   "pineapple pen apple",
   "pine applepen apple"
 ]
 Explanation: Note that you are allowed to reuse a dictionary word.
 Example 3:

 Input:
 s = "catsandog"
 wordDict = ["cats", "dog", "sand", "and", "cat"]
 Output:
 []
 
 */

class Solution {
  func wordBreak(_ s: String, _ wordDict: [String]) -> [String] {
    var cache: [String: [String]] = [:]
    let result = wordBreakHelper(s, wordDict, &cache)
    
    return result
  }
  
  private func wordBreakHelper(_ s: String, _ wordDict: [String], _ cache: inout [String: [String]]) -> [String] {
    
    if let cached = cache[s] {
      return cached
    }
    
    var result = [String]()
    
    for word in wordDict where s.hasPrefix(word) {
      if word == s {
        result.append(word)
        continue
      }
      
      let newString = String(s[word.endIndex...])
      let words = wordBreakHelper(newString, wordDict, &cache)
      
      for w in words {
        result.append(word + " " + w)
      }
    }
    
    cache[s] = result
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
    let expected = [
      "pine apple pen apple",
      "pine applepen apple",
      "pineapple pen apple"
    ]
    
    let actual = solution.wordBreak("pineapplepenapple", ["apple", "pen", "applepen", "pine", "pineapple"])
    
    XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
  }
  
  func test2() {
    let expected: [String] = []
    
    let actual = solution.wordBreak("catsandog", ["cats", "dog", "sand", "and", "cat"])
    
    XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
  }
  
  func test3() {
    let expected = [
      "cat sand dog",
      "cats and dog"
    ]
    
    let actual = solution.wordBreak("catsanddog", ["cat", "cats", "and", "sand", "dog"])
    
    XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
  }
  
  func testLong() {
    let expected: [String] = []
    let s = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaab"
    let actual = solution.wordBreak(s, ["a","aa","aaa","aaaa","aaaaa","aaaaaa","aaaaaaa","aaaaaaaa","aaaaaaaaa","aaaaaaaaaa"])
    
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


