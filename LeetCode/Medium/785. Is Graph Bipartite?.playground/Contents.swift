import Foundation
import XCTest

/*
 Given an undirected graph, return true if and only if it is bipartite.
 Recall that a graph is bipartite if we can split it's set of nodes into
 two independent subsets A and B such that every edge in the graph has one node
 in A and another node in B.

 The graph is given in the following form: graph[i] is a list of indexes j for
 which the edge between nodes i and j exists.  Each node is an integer between 0 and graph.length - 1.
 There are no self edges or parallel edges: graph[i] does not contain i, and it doesn't contain any
 element twice.

 Example 1:
 Input: [[1,3], [0,2], [1,3], [0,2]]
 Output: true
 Explanation:
 The graph looks like this:
 0----1
 |    |
 |    |
 3----2
 We can divide the vertices into two groups: {0, 2} and {1, 3}.
 
 
 Example 2:
 Input: [[1,2,3], [0,2], [0,1,3], [0,2]]
 Output: false
 Explanation:
 The graph looks like this:
 0----1
 | \  |
 |  \ |
 3----2
 We cannot find a way to divide the set of nodes into two independent subsets.
 */

class Solution {
  func isBipartite(_ graph: [[Int]]) -> Bool {
    var left = Set<Int>()
    var right = Set<Int>()
    var visited = Set<Int>()
    
    for i in 0..<graph.count where !visited.contains(i) {
      if !isBipartite(graph, &left, &right, &visited, i) {
        return false
      }
    }
    
    return true
  }
  
  func isBipartite(
    _ graph: [[Int]],
    _ left: inout Set<Int>,
    _ right: inout Set<Int>,
    _ visited: inout Set<Int>,
    _ current: Int
  ) -> Bool {
    
    visited.insert(current)
    
    var foundLeft = false
    var foundRight = false
    
    for node in graph[current] {
      if left.contains(node) {
        foundLeft = true
        continue
      }
      
      if right.contains(node) {
        foundRight = true
        continue
      }
    }
    
    if foundLeft && foundRight {
      //It's not a bipartite graph
      return false
    } else if foundLeft {
      right.insert(current)
    } else {
      left.insert(current)
    }
    
    for node in graph[current] where !visited.contains(node) {
      if !isBipartite(graph, &left, &right, &visited, node) {
        return false
      }
    }
    
    return true
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
    let expected = false
    let actual = solution.isBipartite([[2,4],[2,3,4],[0,1],[1],[0,1],[7],[9],[5],[],[6],[12,14],[],[10],[],[10],[19],[18],[],[16],[15],[23],[23],[],[20,21],[],[],[27],[26],[],[],[34],[33,34],[],[31],[30,31],[38,39],[37,38,39],[36],[35,36],[35,36],[43],[],[],[40],[],[49],[47,48,49],[46,48,49],[46,47,49],[45,46,47,48]])
    
    XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
  }
  
  func test2() {
    let expected = false
    let actual = solution.isBipartite([[1,2,3], [0,2], [0,1,3], [0,2]])
    
    XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
  }
  
  func test3() {
    let expected = true
    let actual = solution.isBipartite([[1,3], [0,2], [1,3], [0,2]])
    
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
