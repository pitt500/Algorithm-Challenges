import Foundation
import XCTest

/*
 Remove the minimum number of invalid parentheses in order to make the input string valid. Return all possible results.

 Note: The input string may contain letters other than the parentheses ( and ).

 Example 1:

 Input: "()())()"
 Output: ["()()()", "(())()"]
 Example 2:

 Input: "(a)())()"
 Output: ["(a)()()", "(a())()"]
 Example 3:

 Input: ")("
 Output: [""]
 
 */

class Queue {
  private var waiting: [String] = []
  private var process: [String] = []
  
  func pop() -> String? {
    fillProcessIfNeeded()
    return process.popLast()
  }
  
  func append(_ s: String) {
    waiting.append(s)
  }
  
  var hasValues: Bool {
    return !waiting.isEmpty || !process.isEmpty
  }
  
  private func fillProcessIfNeeded() {
    if process.isEmpty {
      while !waiting.isEmpty {
        process.append(waiting.removeLast())
      }
    }
  }
}

class Solution {
  func removeInvalidParentheses(_ s: String) -> [String] {
    var visited = Set<String>()
    var result = [String]()
    
    let queue = Queue()
    var found = false
    
    queue.append(s)
    visited.insert(s)
    
    while queue.hasValues {
      let current = queue.pop()!
      
      if isValid(current) {
        result.append(current)
        found = true
      }
      
      if found {
        //No more enqueuing, just checking if remaining items in queue are valid too.
        continue
      }
      
      let arrayCurr = Array(current)
      for i in 0..<arrayCurr.count where isParenthesis(arrayCurr[i]) {
        //String excluding current parenthesis
        let temp = String(arrayCurr[0..<i] + arrayCurr[(i+1)...])
        
        if !visited.contains(temp) {
          visited.insert(temp)
          queue.append(temp)
        }
      }
    }
    
    return result
  }
  
  private func isValid(_ s: String) -> Bool {
    var count = 0
    
    for c in s {
      if c == "(" {
        count += 1
      } else if c == ")" {
        guard count > 0 else { return false }
        count -= 1
      }
    }
    
    return count == 0
  }
  
  private func isParenthesis(_ c: Character) -> Bool {
    return c == "(" || c == ")"
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
    let expected = ["(())()","()()()"]
    let actual = solution.removeInvalidParentheses("()())()")
    
    XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
  }
  
  func test2() {
    let expected = ["(a)()()", "(a())()"].sorted()
    let actual = solution.removeInvalidParentheses("(a)())()").sorted()
    
    XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
  }
  
  func test3() {
    let expected = [""]
    let actual = solution.removeInvalidParentheses(")(")
    
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




