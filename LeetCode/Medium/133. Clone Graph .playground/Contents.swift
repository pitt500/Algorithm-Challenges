import Foundation
import XCTest

/*
 
 Given a reference of a node in a connected undirected graph.
 
 Return a deep copy (clone) of the graph.
 
 Each node in the graph contains a val (int) and a list (List[Node]) of its neighbors.
 
 class Node {
 public int val;
 public List<Node> neighbors;
 }
 
 
 Test case format:
 
 For simplicity sake, each node's value is the same as the node's index (1-indexed).
 For example, the first node with val = 1, the second node with val = 2, and so on.
 The graph is represented in the test case using an adjacency list.
 
 Adjacency list is a collection of unordered lists used to represent a finite graph.
 Each list describes the set of neighbors of a node in the graph.
 
 The given node will always be the first node with val = 1.
 You must return the copy of the given node as a reference to the cloned graph.
 
 */


class Node: Hashable {
  var val: Int
  var neighbors: [Node?]
  init(_ val: Int) {
    self.val = val
    self.neighbors = []
  }
  
  static func == (lhs: Node, rhs: Node) -> Bool {
    lhs.val == rhs.val
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(val)
  }
}

class Solution {
  func cloneGraph(_ node: Node?) -> Node? {
    var visited = [Node: Node]()
    return cloneHelper(node, &visited)
  }
  
  private func cloneHelper(_ node: Node?,_ visited: inout [Node: Node]) -> Node? {
    guard let node = node else {
      return nil
    }
    
    if let saved = visited[node] {
      return saved
    }
    
    let newNode = Node(node.val)
    visited[node] = newNode
    
    for nei in node.neighbors {
      newNode.neighbors.append(cloneHelper(nei, &visited))
    }
    
    return newNode
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
    let node1 = Node(1)
    let node2 = Node(2)
    let node3 = Node(3)
    let node4 = Node(4)
    node1.neighbors = [node2, node3]
    node2.neighbors = [node1, node4]
    node3.neighbors = [node1, node4]
    node4.neighbors = [node2, node3]
    
    let actual = solution.cloneGraph(node1)
    //Reference should be different
    XCTAssertTrue(node1 !== actual, "\nexpected value is \(node1), but actual is \(String(describing: actual))\n")
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


