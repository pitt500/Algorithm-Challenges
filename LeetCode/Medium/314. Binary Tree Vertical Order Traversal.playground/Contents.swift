import Foundation
import XCTest

/*
 
 Given a binary tree, return the vertical order traversal of its nodes' values. (ie, from top to bottom, column by column).
 If two nodes are in the same row and column, the order should be from left to right.
 Examples 1:
 Input:
    3
   /\
  /  \
  9  20
     /\
    /  \
   15   7
 Output:
 [
   [9],
   [3,15],
   [20],
   [7]
 ]
 Examples 2:
 Input:
      3
     /\
    /  \
    9   8
   /\  /\
  /  \/  \
  4  01   7
 Output:
 [
   [4],
   [9],
   [3,0,1],
   [8],
   [7]
 ]
 Examples 3:
 Input: (0's right child is 2 and 1's left child is 5)
      3
     /\
    /  \
    9   8
   /\  /\
  /  \/  \
  4  01   7
     /\
    /  \
    5   2
 Output:
 [
   [4],
   [9,5],
   [3,0,1],
   [8,2],
   [7]
 ]
 
 */

class TreeNode {
  var val: Int
  var left: TreeNode?
  var right: TreeNode?
  
  init(val: Int) {
    self.val = val
  }
}

class Solution {
  typealias TaggedNode = (node: TreeNode, column: Int)
  
  func verticalOrder(_ root: TreeNode?) -> [[Int]] {
    
    guard let root = root else {
      return []
    }
    
    var ans = [Int: [Int]]()
    
    //we use two stacks to simulate a queue
    var waitingQueue: [TaggedNode] = [(root,0)]
    var processQueue: [TaggedNode] = []
    
    //save range of columns to avoid sorting
    var minColumn = 0
    var maxColumn = 0
    
    while !waitingQueue.isEmpty {
      while !waitingQueue.isEmpty {
        processQueue.append(waitingQueue.removeLast())
      }
      
      while !processQueue.isEmpty {
        let obj = processQueue.removeLast()
        
        minColumn = min(minColumn, obj.column)
        maxColumn = max(maxColumn, obj.column)
        
        ans[obj.column, default: []].append(obj.node.val)
        
        if let left = obj.node.left {
          waitingQueue.append((left, obj.column - 1))
        }
        
        if let right = obj.node.right {
          waitingQueue.append((right, obj.column + 1))
        }
      }
      
    }
    
    
    var result = [[Int]]()
    for i in minColumn...maxColumn {
      result.append(ans[i]!)
    }
    
    return result
    
    
    //BFS
    //Tag each node by column
    //If node is from left, column -= 1, if it's right, column += 1
    //From a queue:
    /*
     - Read node from processQueue and put in ans[column]
     - Calculate the min and max range of columns
     - Read children and put in the waitingQueue
     - Do this until waitingQueue is empty
     
     - map ans into the result array
     */
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
      [9,10,5],
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
    
    let actual = solution.verticalOrder(root)
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


