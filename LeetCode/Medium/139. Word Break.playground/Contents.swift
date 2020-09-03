import Foundation
import XCTest

/*
 Given a non-empty string s and a dictionary wordDict containing a list of non-empty words,
 determine if s can be segmented into a space-separated sequence of one or more dictionary words.

 Note:

 The same word in the dictionary may be reused multiple times in the segmentation.
 You may assume the dictionary does not contain duplicate words.
 Example 1:

 Input: s = "leetcode", wordDict = ["leet", "code"]
 Output: true
 Explanation: Return true because "leetcode" can be segmented as "leet code".
 Example 2:

 Input: s = "applepenapple", wordDict = ["apple", "pen"]
 Output: true
 Explanation: Return true because "applepenapple" can be segmented as "apple pen apple".
              Note that you are allowed to reuse a dictionary word.
 Example 3:

 Input: s = "catsandog", wordDict = ["cats", "dog", "sand", "and", "cat"]
 Output: false
 
 */

class Solution {
  func wordBreak(_ s: String, _ wordDict: [String]) -> Bool {
    var cache: [String: Bool] = [:]
    return wordBreakHelper(s, wordDict, &cache)
  }
  
  private func wordBreakHelper(_ s: String, _ wordDict: [String], _ cache: inout [String: Bool]) -> Bool {
    
    if let cached = cache[s] {
      return cached
    }
    
    for word in wordDict where s.hasPrefix(word){
      let string = stringWithoutPrefix(word, s)
      
      if string.isEmpty {
        return true
      } else {
        let isBreakable = wordBreakHelper(string, wordDict, &cache)
        cache[string] = isBreakable
        
        if isBreakable {
          return true
        }
      }
    }
    
    return false
  }
  
  private func stringWithoutPrefix(_ prefix: String, _ s: String) -> String {
    let newString = Array(s)
    return String(newString[prefix.count...])
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
    let expected = true
    
    let actual = solution.wordBreak("applepenapple", ["apple", "pen"])
    
    XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
  }
  
  func test2() {
    let expected = false
    
    let actual = solution.wordBreak("catsandog", ["cats", "dog", "sand", "and", "cat"])
    
    XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
  }
  
  func test3() {
    let expected = true
    
    let actual = solution.wordBreak("catsanddog", ["cats", "dog", "sand", "and", "cat"])
    
    XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
  }
  
  func testLong() {
    let expected = false
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


