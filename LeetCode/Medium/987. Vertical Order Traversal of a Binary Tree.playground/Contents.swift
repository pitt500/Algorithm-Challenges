import Foundation
import XCTest

/*
 
 Given a binary tree, return the vertical order traversal of its nodes values.
 For each node at position (X, Y), its left and right children respectively will be at positions (X-1, Y-1) and (X+1, Y-1).
 Running a vertical line from X = -infinity to X = +infinity,
 whenever the vertical line touches some nodes, we report the values of the
 nodes in order from top to bottom (decreasing Y coordinates).
 
 If two nodes have the same position, then the value of the node that is reported first is the value that is smaller.
 Return an list of non-empty reports in order of X coordinate.  Every report will have a list of values of nodes.
 
 Example 1:
 Input:
         3
        / \
       9   20
          /  \
         15   7
 Output: [[9],[3,15],[20],[7]]
 Explanation:
 Without loss of generality, we can assume the root node is at position (0, 0):
 Then, the node with value 9 occurs at position (-1, -1);
 The nodes with values 3 and 15 occur at positions (0, 0) and (0, -2);
 The node with value 20 occurs at position (1, -1);
 The node with value 7 occurs at position (2, -2).
 
 Example 2:
 Input:
                1
              /   \
             2     3
            / \   / \
           4   5 6   7
 Output: [[4],[2],[1,5,6],[3],[7]]
 Explanation:
 The node with value 5 and the node with value 6 have the same position according to the given scheme.
 However, in the report "[1,5,6]", the node value of 5 comes first since 5 is **before** 6.
 Note:
 The tree will have between 1 and 1000 nodes.
 Each node's value will be between 0 and 1000.
 */

class TreeNode {
  var val: Int
  var left: TreeNode?
  var right: TreeNode?
  
  init(val: Int) {
    self.val = val
  }
}

typealias TaggedNode = (node: TreeNode, column: Int, row: Int)

class Solution {
    func verticalTraversal(_ root: TreeNode?) -> [[Int]] {
        guard let root = root else { return [] }
        
        var result: [Int: [TaggedNode]] = [:]
        var array = [[Int]]()
        
        //we use two stacks to simulate a queue
        var waitingQueue: [TaggedNode] = []
        var processQueue: [TaggedNode] = []
        
        var minCol = 0
        var maxCol = 0
        var level = 0
        
        waitingQueue.append((root, 0, 0))
        
        while !waitingQueue.isEmpty {
            while !waitingQueue.isEmpty {
                processQueue.append(waitingQueue.removeLast())
            }
            level += 1
            
            while !processQueue.isEmpty {
                let taggedNode = processQueue.removeLast()
                let node = taggedNode.node
                let col = taggedNode.column

                result[col, default: []].append(taggedNode)

                if let left = node.left {
                    waitingQueue.append((left, col - 1, level))
                    minCol = min(minCol, col - 1)
                }

                if let right = node.right {
                    waitingQueue.append((right, col + 1, level))
                    maxCol = max(maxCol, col + 1)
                }
            }
        }
        
        for i in minCol...maxCol {
            array.append(result[i]!.sorted(by: sortingCriteria).map { $0.node.val } )
        }
        
        return array
    }
    
    private func sortingCriteria(_ nodeA: TaggedNode, _ nodeB: TaggedNode) -> Bool {
        
        if nodeA.column == nodeB.column && nodeA.row == nodeB.row {
            return nodeA.node.val <= nodeB.node.val
        }
        
        return nodeA.column < nodeB.column && nodeA.row < nodeB.row
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
      [4],
      [9,5,10],
      [3,0,1],
      [8,2],
      [7]
    ]
    let root = TreeNode(val: 3)
    root.left = TreeNode(val: 9)
    root.right = TreeNode(val: 8)
    root.left?.left = TreeNode(val: 4)
    root.left?.right = TreeNode(val: 0)
    root.left?.left?.right = TreeNode(val: 10)
    root.left?.right?.right = TreeNode(val: 2)
    root.right?.left = TreeNode(val: 1)
    root.right?.right = TreeNode(val: 7)
    root.right?.left?.left = TreeNode(val: 5)
    
    let actual = solution.verticalTraversal(root)
    //Reference should be different
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


