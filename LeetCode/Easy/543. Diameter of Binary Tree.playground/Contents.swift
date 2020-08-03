import Foundation
import XCTest

/*
 Given a binary tree, you need to compute the length of the diameter of the tree. The diameter of a binary tree is the length of the longest path between any two nodes in a tree. This path may or may not pass through the root.

 Example:
 Given a binary tree
           1
          / \
         2   3
        / \
       4   5
 Return 3, which is the length of the path [4,2,1,3] or [5,2,1,3].

 Note: The length of path between two nodes is represented by the number of edges between them.
 
 */

public class TreeNode {
  public var val: Int
  public var left: TreeNode?
  public var right: TreeNode?
  public init() { self.val = 0; self.left = nil; self.right = nil; }
  public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
  public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
    self.val = val
    self.left = left
    self.right = right
  }
}

class Solution {
  func diameterOfBinaryTree(_ root: TreeNode?) -> Int {
    var result = 0
    _ = maxDiameter(of: root, &result)
    return result
  }
  
  private func maxDiameter(of node: TreeNode?,_ result: inout Int) -> Int {
    guard let node = node else {
      return 0
    }
    
    let left = maxDiameter(of: node.left, &result)
    let right = maxDiameter(of: node.right, &result)
    
    result = max(result, left + right)
    return max(left, right) + 1
  }
}

class TestSolution: XCTestCase {
  var solution: Solution!
  
  override func setUp() {
    super.setUp()
    self.solution = Solution()
  }
  
  func test1() {
    let expected = 6
    let root = TreeNode(1)
    root.left = TreeNode(2)
    root.right = TreeNode(3)
    root.left!.left = TreeNode(4)
    root.left!.right = TreeNode(5)
    root.left!.right!.left = TreeNode(11)
    root.left!.right!.right = TreeNode(12)
    root.left!.right!.right!.left = TreeNode(13)
    root.left!.right!.right!.right = TreeNode(14)
    
    root.left!.left!.left = TreeNode(7)
    root.left!.left!.right = TreeNode(8)
    root.left!.left!.right!.left = TreeNode(9)
    root.left!.left!.right!.right = TreeNode(10)
    
    let actual = solution.diameterOfBinaryTree(root)
    
    XCTAssertTrue(expected == actual, "\nWrong Answer: expected is \(expected), but actual is \(actual)\n")
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
