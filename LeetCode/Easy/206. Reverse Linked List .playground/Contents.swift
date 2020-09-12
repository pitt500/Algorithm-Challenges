import Foundation
import XCTest

/*
 Reverse a singly linked list.

 Example:

 Input: 1->2->3->4->5->NULL
 Output: 5->4->3->2->1->NULL
 Follow up:

 A linked list can be reversed either iteratively or recursively. Could you implement both?
 
 */

class ListNode {
  var val: Int
  var next: ListNode?
  
  init(_ val: Int) {
    self.val = val
  }
}

class Solution {
  
  //recursive
  func reverseList(_ head: ListNode?) -> ListNode? {
    guard let node = head, node.next != nil else {
      return head
    }
    
    let reversed = reverseList(node.next)
    
    node.next?.next = node
    node.next = nil
    
    return reversed
  }
  
  //iterative
  func reverseList_iterative(_ head: ListNode?) -> ListNode? {
    var result: ListNode?
    var node = head
    
    while node != nil {
      let newNode = ListNode(node!.val)
      newNode.next = result
      result = newNode
      
      node = node?.next
    }
    
    return result
  }
}

//MARK: - Testing
class TestSolution: XCTestCase {
  var solution: Solution!
  
  override func setUp() {
    super.setUp()
    self.solution = Solution()
  }
  
  func testRecursive() {
    let list = ListNode(1)
    list.next = ListNode(2)
    list.next?.next = ListNode(3)
    list.next?.next?.next = ListNode(4)
    list.next?.next?.next?.next = ListNode(5)
    
    
    let expected = ListNode(5)
    let actual = solution.reverseList(list)!
    
    XCTAssertTrue(expected.val == actual.val, "\nexpected value is \(expected), but actual is \(actual)\n")
  }
  
  func testIterative() {
    let list = ListNode(1)
    list.next = ListNode(2)
    list.next?.next = ListNode(3)
    list.next?.next?.next = ListNode(4)
    list.next?.next?.next?.next = ListNode(5)
    
    
    let expected = ListNode(5)
    let actual = solution.reverseList_iterative(list)!
    
    XCTAssertTrue(expected.val == actual.val, "\nexpected value is \(expected), but actual is \(actual)\n")
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





