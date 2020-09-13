import Foundation
import XCTest

/*
 There is a new alien language which uses the latin alphabet.
 However, the order among letters are unknown to you.
 You receive a list of non-empty words from the dictionary,
 where words are sorted lexicographically by the rules of this new language.
 Derive the order of letters in this language.

 Example 1:

 Input:
 [
   "wrt",
   "wrf",
   "er",
   "ett",
   "rftt"
 ]

 Output: "wertf"
 Example 2:

 Input:
 [
   "z",
   "x"
 ]

 Output: "zx"
 Example 3:

 Input:
 [
   "z",
   "x",
   "z"
 ]

 Output: ""

 Explanation: The order is invalid, so return "".
 Note:

 You may assume all letters are in lowercase.
 If the order is invalid, return an empty string.
 There may be multiple valid order of letters, return any one of them is fine.
 
 */

class Solution {
  func alienOrder(_ words: [String]) -> String {
    let words = words.map { Array($0) }
    guard haveValidPrefixes(words) else {
      return ""
    }
    
    var graph = buildGraph(words)
    buildDependencies(words, &graph)
    
    return topologicalSort(graph)
  }
  
  private func buildGraph(_ words: [[Character]]) -> [Character: [Character]] {
    var graph = [Character: [Character]]()
    
    for w in words {
      for l in w {
        graph[l] = []
      }
    }
    
    return graph
  }
  
  private func haveValidPrefixes(_ words: [[Character]]) -> Bool {
    for i in 0..<(words.count - 1) {
      let word1 = String(words[i])
      let word2 = String(words[i+1])
      
      if word1.count > word2.count && word1.hasPrefix(word2) {
        return false
      }
    }
    
    return true
  }
  
  private func buildDependencies(_ words: [[Character]], _ graph: inout [Character: [Character]]) {
    
    //Reversed dependencies to avoid reverse final result string
    for i in 0..<(words.count - 1) {
      for j in 0..<(min(words[i].count, words[i+1].count)) where words[i][j] != words[i+1][j] {
        let before = words[i][j]
        let after = words[i+1][j]
        graph[after, default: []].append(before)
        break
      }
    }
  }
  
  private func topologicalSort(_ graph: [Character: [Character]]) -> String {
    var result = ""
    var visited = [Character: NodeState]()
    
    for key in graph.keys {
      let cycleDetected = sortDependencies(key, graph, &visited, &result)
      
      if cycleDetected {
        return ""
      }
    }
    
    return result
  }
  
  private func sortDependencies(
    _ letter: Character,
    _ graph: [Character: [Character]],
    _ visited: inout  [Character: NodeState],
    _ result: inout String
  ) -> Bool {
    
    if let state = visited[letter] {
      return state == .visiting ? true : false
    }
    
    visited[letter] = .visiting
    
    for l in graph[letter, default: []] {
      let cycleDetected = sortDependencies(l, graph, &visited, &result)
      
      if cycleDetected {
        return true
      }
    }
    visited[letter] = .finished
    
    result.append(letter)
    return false
  }
}

enum NodeState {
  case visiting
  case finished
}

//MARK: - Testing
class TestSolution: XCTestCase {
  var solution: Solution!
  
  override func setUp() {
    super.setUp()
    self.solution = Solution()
  }
  
  func test1() {
    let expected = "z"
    let actual = solution.alienOrder(["z", "z"])
    
    XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
  }
  
  func test2() {
    let expected = "wertf"
    let actual = solution.alienOrder([
      "wrt",
      "wrf",
      "er",
      "ett",
      "rftt"
    ])
    
    XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
  }
  
  func test3() {
    let expected = ""
    let actual = solution.alienOrder([
      "x",
      "z",
      "x"
    ])
    
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




