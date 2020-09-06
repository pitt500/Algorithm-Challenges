import Foundation
import XCTest

/*
 Serialization is the process of converting a data structure or object into a
 sequence of bits so that it can be stored in a file or memory buffer, or transmitted
 across a network connection link to be reconstructed later in the same or another computer environment.

 Design an algorithm to serialize and deserialize a binary tree.
 There is no restriction on how your serialization/deserialization algorithm should work.
 You just need to ensure that a binary tree can be serialized to a string and this string
 can be deserialized to the original tree structure.

 Example:

 You may serialize the following tree:

     1
    / \
   2   3
      / \
     4   5

 as "[1,2,3,null,null,4,5]"
 Clarification: The above format is the same as how LeetCode serializes a binary tree.
 You do not necessarily need to follow this format, so please be creative and come up with
 different approaches yourself.

 Note: Do not use class member/global/static variables to store states. Your serialize and
 deserialize algorithms should be stateless.
 
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
  func serialize(_ root: TreeNode?) -> String {
    var result = ""
    
    guard let root = root else {
      return ""
    }
    
    //Simulation of a queue
    var waitingStack: [TreeNode?] = [root]
    var processStack: [TreeNode?] = []
    
    
    while !waitingStack.isEmpty {
      while !waitingStack.isEmpty {
        processStack.append(waitingStack.removeLast())
      }
      
      while !processStack.isEmpty {
        if let node = processStack.removeLast() {
          result += "\(node.val),"
          waitingStack.append(contentsOf: [node.left, node.right])
        } else {
          result += "x,"
        }
      }
      
      result.removeLast()
      result += "|"
      
      if waitingStack.allSatisfy({ $0 == nil }) {
        break
      }
    }
    
    result.removeLast()
    
    return result
  }
  
  func deserialize(_ data: String) -> TreeNode? {
    if data.isEmpty { return nil }
    // Example of string:
    //1|2,3|x,12,4,x|x,x,5,6|10,x,7,8
    
    //Simulation of a queue
    var waitingParents: [TreeNode] = []
    var processParents: [TreeNode] = []
    
    var root: TreeNode?
    let elements = data.split(separator: "|").map { $0.split(separator: ",") }
    var checkLeftSide = true
    
    for level in elements {
      while !waitingParents.isEmpty {
        processParents.append(waitingParents.removeLast())
      }
      
      for c in level {
        if processParents.isEmpty {
          let val = Int(c)!
          root = TreeNode(val)
          waitingParents.append(root!)
        } else {
          let val = Int(c)
          let node = val != nil ? TreeNode(val!) : nil
          
          if checkLeftSide {
            processParents[processParents.count - 1].left = node
          } else {
            processParents[processParents.count - 1].right = node
            processParents.removeLast()
          }
          
          if node != nil {
            waitingParents.append(node!)
          }
          
          checkLeftSide.toggle()
        }
      }
    }
    
    return root
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
  
  func testSerialize() {
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
    
    let expected = "1|2,3|x,12,4,x|x,x,5,6|10,x,7,8"
    
    let actual = solution.serialize(root)
    
    XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
  }
  
  func testDeserialize() {
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
    
    let expected = "1|2,3|x,12,4,x|x,x,5,6|10,x,7,8"
    
    let actual = solution.serialize(solution.deserialize(solution.serialize(root)))
    
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


