import Foundation
import XCTest

/*
 Given an array of linked-lists lists, each linked list is sorted in ascending order.

 Merge all the linked-lists into one sort linked-list and return it.

  

 Example 1:

 Input: lists = [[1,4,5],[1,3,4],[2,6]]
 Output: [1,1,2,3,4,4,5,6]
 Explanation: The linked-lists are:
 [
   1->4->5,
   1->3->4,
   2->6
 ]
 merging them into one sorted list:
 1->1->2->3->4->4->5->6
 Example 2:

 Input: lists = []
 Output: []
 Example 3:

 Input: lists = [[]]
 Output: []
 */

public class ListNode {
  public var val: Int
  public var next: ListNode?
  public init() { self.val = 0; self.next = nil; }
  public init(_ val: Int) { self.val = val; self.next = nil; }
  public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

//MARK: - Optimal
class Solution {
  func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
    guard !lists.isEmpty else {
      return nil
    }
    
    return partition(lists, 0, lists.count - 1)
  }
  
  private func partition(_ lists: [ListNode?], _ start: Int, _ end: Int) -> ListNode? {
    if start == end {
      return lists[start]
    }
    
    if start < end {
      let mid = (start + end) >> 1
      let list1 = partition(lists, start, mid)
      let list2 = partition(lists, mid + 1, end)
      
      return mergeTwoLists(list1, list2)
    }
    
    return nil
  }
  
  func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    
    guard l1 != nil else {
      return l2
    }
    
    guard l2 != nil else {
      return l1
    }
    
    //Checking what list has the smallest number
    var (p1, p2) = l1!.val <= l2!.val ? (l1, l2) : (l2, l1)
    
    let head = p1
    
    while p2 != nil {
      while p1!.val < p2!.val && p1?.next != nil && p1!.next!.val < p2!.val {
        p1 = p1?.next
      }
      
      // This means last element of p1 is less than first p2 element.
      // Let's join the lists without more verifications
      if p1?.next == nil {
        p1?.next = p2
        break
      }
      
      let aux1 = p1?.next
      let aux2 = p2?.next
      
      p1?.next = p2
      p2?.next = aux1
      p1 = p2
      p2 = aux2
    }
    
    return head
  }
  
  //MARK: - Brute force:
  func mergeKLists_brute(_ lists: [ListNode?]) -> ListNode? {
    guard !lists.isEmpty else {
      return nil
    }
    
    let array = convertToArray(lists).sorted(by: <)
    let list = convertToList(array)
    
    return list
  }
  
  private func convertToArray(_ lists: [ListNode?]) -> [Int] {
    var array = [Int]()
    var node: ListNode?
    
    for list in lists {
      node = list
      
      while node != nil {
        array.append(node!.val)
        node = node?.next
      }
    }
    
    return array
  }
  
  private func convertToList(_ array: [Int]) -> ListNode? {
    var node: ListNode?
    var prev: ListNode?
    var head: ListNode?
    
    for val in array {
      node = ListNode(val)
      
      if prev == nil {
        prev = node
        head = node
      } else {
        prev?.next = node
        prev = node
      }
    }
    
    return head
  }
  
}

//MARK: - Testing
class TestSolution: XCTestCase {
  var solution: Solution!
  
  override func setUp() {
    super.setUp()
    self.solution = Solution()
  }
  
  func testOptimal() {
    let expected = [1,1,2,3,4,4,5,6]
    
    let list = [ListNode(2, ListNode(6)), ListNode(1, ListNode(4, ListNode(5))), ListNode(1, ListNode(3, ListNode(4)))]
    
    let actual = solution.mergeKLists(list)
    var array = [Int]()
    
    var node = actual
    while node != nil {
      array.append(node!.val)
      node = node?.next
    }
    
    XCTAssertTrue(expected == array, "\nexpected value is \(expected), but actual is \(array)\n")
  }
  
  func testBrute() {
    let expected = [1,1,2,3,4,4,5,6]
    
    let list = [ListNode(2, ListNode(6)), ListNode(1, ListNode(4, ListNode(5))), ListNode(1, ListNode(3, ListNode(4)))]
    
    let actual = solution.mergeKLists_brute(list)
    var array = [Int]()
    
    var node = actual
    while node != nil {
      array.append(node!.val)
      node = node?.next
    }
    
    XCTAssertTrue(expected == array, "\nexpected value is \(expected), but actual is \(array)\n")
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
