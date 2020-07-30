import Foundation

/*
 Given a binary tree containing digits from 0-9 only, each root-to-leaf path could represent a number.

 An example is the root-to-leaf path 1->2->3 which represents the number 123.

 Find the total sum of all root-to-leaf numbers.

 Note: A leaf is a node with no children.

 Example:

 Input: [1,2,3]
     1
    / \
   2   3
 Output: 25
 Explanation:
 The root-to-leaf path 1->2 represents the number 12.
 The root-to-leaf path 1->3 represents the number 13.
 Therefore, sum = 12 + 13 = 25.
 Example 2:

 Input: [4,9,0,5,1]
     4
    / \
   9   0
  / \
 5   1
 Output: 1026
 Explanation:
 The root-to-leaf path 4->9->5 represents the number 495.
 The root-to-leaf path 4->9->1 represents the number 491.
 The root-to-leaf path 4->0 represents the number 40.
 Therefore, sum = 495 + 491 + 40 = 1026.
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
  func sumNumbers(_ root: TreeNode?) -> Int {
    guard let node = root else { return 0 }
    return sumNumbers(node, 0)
  }
  
  private func sumNumbers(_ node: TreeNode, _ current: Int) -> Int {
    let total = current*10 + node.val
    let isLeaf = node.left == nil && node.right == nil
    
    if isLeaf { return total }
    
    var result = 0
    
    if let left = node.left {
      result += sumNumbers(left, total)
    }
    
    if let right = node.right {
      result += sumNumbers(right, total)
    }
    
    return result
  }
}

/*
     4
    / \
   9   0
  / \
 5   1
 */

let root = TreeNode(4)
root.left = TreeNode(9)
root.right = TreeNode(0)
root.left?.left = TreeNode(5)
root.left?.right = TreeNode(1)

let expected = 1026

let result = Solution().sumNumbers(root)

if expected == result {
  print("Success")
} else {
  print("Invalid result")
}
