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
  func rangeSumBST(_ root: TreeNode?, _ L: Int, _ R: Int) -> Int {
    guard let node = root else {
      return 0
    }
    
    let value = node.val
    let greaterThanL = value >= L
    let lessThanR = value <= R
    
    if greaterThanL && lessThanR {
      return value + rangeSumBST(node.left, L, R) + rangeSumBST(node.right, L, R)
    } else if greaterThanL {
      return rangeSumBST(node.left, L, R)
    } else if lessThanR {
      return rangeSumBST(node.right, L, R)
    }
    
    return 0
  }
}

class TestSolution: XCTestCase {
  var solution: Solution!
  
  override func setUp() {
    super.setUp()
    self.solution = Solution()
  }
  
  func test1() {
    let expected = 32
    let root = TreeNode(10)
    root.left = TreeNode(5)
    root.right = TreeNode(15)
    root.left!.left = TreeNode(3)
    root.left!.right = TreeNode(7)
    root.right!.right = TreeNode(18)
    
    let actual = solution.rangeSumBST(root, 7, 15)
    
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
