import Foundation
import XCTest

/*
 
 Given the root of a binary tree, find the maximum value V for which there exists different nodes A and B where V = |A.val - B.val| (abs) and A is an ancestor of B.
 (A node A is an ancestor of B if either: any child of A is equal to B, or any child of A is an ancestor of B.)
 Example:
 input:
            8
           / \
          3   10
         / \    \
        1   6    14
           / \   /
          4   7 13
 Output: 7
 Explanation:
 We have various ancestor-node differences, some of which are given below :
 |8 - 3| = 5
 |3 - 7| = 4
 |8 - 1| = 7
 |10 - 13| = 3
 Among all possible differences, the maximum value of 7 is obtained by |8 - 1| = 7.
 
 */

class TreeNode {
  let val: Int
  var left: TreeNode?
  var right: TreeNode?
  
  init(_ val: Int) {
    self.val = val
  }
}

class Solution {
  func maxAncestorDiff(_ root: TreeNode?) -> Int {
    guard let node = root else {
      return 0
    }
    
    return maxDiff(node, node.val, node.val)
  }
  
  private func maxDiff(_ root: TreeNode?, _ minVal: Int, _ maxVal: Int) -> Int {
    
    guard let node = root else {
      return abs(minVal - maxVal)
    }
    
    let minVal = min(minVal,  node.val)
    let maxVal = max(maxVal, node.val)
    let leftDiff = maxDiff(node.left, minVal, maxVal)
    let rightDiff = maxDiff(node.right, minVal, maxVal)
    
    return max(leftDiff, rightDiff)
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
    let root = TreeNode(8)
    root.left = TreeNode(3)
    root.right = TreeNode(10)
    root.left?.left = TreeNode(1)
    root.left?.right = TreeNode(6)
    root.left?.right?.left = TreeNode(4)
    root.left?.right?.right = TreeNode(7)
    root.right?.right = TreeNode(14)
    root.right?.right?.left = TreeNode(13)
    
    let expected = 7
    let actual = solution.maxAncestorDiff(root)
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


