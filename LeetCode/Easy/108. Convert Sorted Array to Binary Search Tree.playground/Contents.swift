import UIKit
import XCTest

//Definition for a binary tree node.
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
  func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
    return binarySearchPreorder(nums, 0, nums.count - 1)
  }
  
  private func binarySearchPreorder(_ nums: [Int],_ start: Int,_ end: Int) -> TreeNode? {
    let mid = start + (end - start)/2
    
    guard mid >= start && mid <= end else {
      return nil
    }
    
    let node = TreeNode(nums[mid])
    
    node.left = binarySearchPreorder(nums, start, mid - 1)
    node.right = binarySearchPreorder(nums, mid + 1, end)
    
    return node
  }
  
  //Helper:
  func printInOrder(_ node: TreeNode?,_ result: inout [Int]) {
    guard let val = node?.val else {
      return
    }
    
    printInOrder(node?.left, &result)
    result.append(val)
    printInOrder(node?.right, &result)
  }
}

class TestSolution: XCTestCase {
  var solution: Solution!
  
  override func setUp() {
    super.setUp()
    solution = Solution()
  }
  
  func test1() {
    let expected = [-10, -7, 1, 3, 4, 6, 11, 15]
    let tree = solution.sortedArrayToBST(expected)
    var actual = [Int]()
    
    solution.printInOrder(tree, &actual)
    
    assert(expected == actual)
  }
  
  func test2() {
    let expected = [-10,-3,0,5,9]
    let tree = solution.sortedArrayToBST(expected)
    var actual = [Int]()
    
    solution.printInOrder(tree, &actual)
    
    assert(expected == actual)
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
