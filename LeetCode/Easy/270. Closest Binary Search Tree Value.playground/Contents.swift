import Foundation
import XCTest

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
  func closestValue(_ root: TreeNode?, _ target: Double) -> Int {
    var result = Double(root!.val)
    var node = root
    
    while node != nil {
      let value = Double(node!.val)
      let nodeDiff = abs(value - target)
      let minDiff = abs(result - target)
      
      if nodeDiff < minDiff {
        result = value
      }
      
      node = target < value ? node!.left : node!.right
    }
    
    return Int(result)
  }
}


class TestSolution: XCTestCase {
  var solution: Solution!
  
  override func setUp() {
    super.setUp()
    self.solution = Solution()
  }
  
  func test1() {
    let expected = 4
    let root = TreeNode(4)
    root.left = TreeNode(2)
    root.right = TreeNode(5)
    root.left?.left = TreeNode(1)
    root.left?.right = TreeNode(3)
  
    let actual = solution.closestValue(root, 3.714286)
    
    XCTAssertTrue(expected == actual, "Wrong Answer")
  }
  
  func test2() {
    let expected = 3
    let root = TreeNode(4)
    root.left = TreeNode(2)
    root.right = TreeNode(5)
    root.left?.left = TreeNode(1)
    root.left?.right = TreeNode(3)
  
    let actual = solution.closestValue(root, 3.1)
    
    XCTAssertTrue(expected == actual, "Wrong Answer")
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
