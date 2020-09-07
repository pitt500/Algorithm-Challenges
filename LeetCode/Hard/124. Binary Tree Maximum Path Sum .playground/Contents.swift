import Foundation
import XCTest

/*
 Given a non-empty binary tree, find the maximum path sum.

 For this problem, a path is defined as any sequence of nodes from some
 starting node to any node in the tree along the parent-child connections.
 The path must contain at least one node and does not need to go through the root.

 Example 1:

 Input: [1,2,3]

        1
       / \
      2   3

 Output: 6
 Example 2:

 Input: [-10,9,20,null,null,15,7]

    -10
    / \
   9  20
     /  \
    15   7

 Output: 42
 
 */

class TreeNode {
  var val: Int
  var left: TreeNode?
  var right: TreeNode?
  
  init(_ val: Int) {
    self.val = val
  }
}

class Solution {
  func maxPathSum(_ root: TreeNode?) -> Int {
    var maxSum = Int(Int32.min)
    maxPathHelper(root, &maxSum)
    
    return maxSum
  }
  
  private func maxPathHelper(_ root: TreeNode?, _ maxSum: inout Int) -> Int {
    guard let node = root else {
      return 0
    }
    
    let left = max(maxPathHelper(node.left, &maxSum), 0)
    let right = max(maxPathHelper(node.right, &maxSum), 0)
    maxSum = max(maxSum, left + right + node.val)
    
    return node.val + max(left, right)
  }
}

//MARK: - Testing
class TestSolution: XCTestCase {
  var solution: Solution!
  
  override func setUp() {
    super.setUp()
    self.solution = Solution()
  }
  
  /*
   Test use the following tree:
                     1
                   /   \
                  2     3
                   \   /
                   12  4
                      / \
                     5   6
                    /   / \
                  10   7   8
   
   */
  
  func test1() {
    let root = TreeNode(1)
    
    root.left = TreeNode(2)
    root.right = TreeNode(3)
    
    root.left?.right = TreeNode(12)
    root.right?.left = TreeNode(4)
    
    root.right?.left?.left = TreeNode(5)
    root.right?.left?.right = TreeNode(6)
    
    root.right?.left?.left?.left = TreeNode(10)
    root.right?.left?.right?.left = TreeNode(7)
    root.right?.left?.right?.right = TreeNode(8)
    
    let expected = 37
    let actual = solution.maxPathSum(root)
    
    XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
  }
  
  func test2() {
    let root = TreeNode(-10)
    root.left = TreeNode(99)
    root.right = TreeNode(20)
    root.right?.left = TreeNode(15)
    root.right?.right = TreeNode(7)
    
    let expected = 124
    let actual = solution.maxPathSum(root)
    
    XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
  }
  
  func test3() {
    let root = TreeNode(2)
    root.left = TreeNode(-1)
    
    let expected = 2
    let actual = solution.maxPathSum(root)
    
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


