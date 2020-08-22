import Foundation
import XCTest

/*
 
 Given a list accounts, each element accounts[i] is a list of strings,
 where the first element accounts[i][0] is a name, and the rest of the
 elements are emails representing emails of the account.
 
 Now, we would like to merge these accounts. Two accounts definitely
 belong to the same person if there is some email that is common to
 both accounts. Note that even if two accounts have the same name,
 they may belong to different people as people could have the same name.
 A person can have any number of accounts initially, but all of their
 accounts definitely have the same name.
 
 After merging the accounts, return the accounts in the following format:
 the first element of each account is the name, and the rest of the elements
 are emails in sorted order. The accounts themselves can be returned in any order.
 
 Example 1:
 Input:
 accounts = [["John", "johnsmith@mail.com", "john00@mail.com"],
 ["John", "johnnybravo@mail.com"], ["John", "johnsmith@mail.com", "john_newyork@mail.com"], ["Mary", "mary@mail.com"]]
 
 Output: [["John", 'john00@mail.com', 'john_newyork@mail.com', 'johnsmith@mail.com'],
 ["John", "johnnybravo@mail.com"], ["Mary", "mary@mail.com"]]
 
 Explanation:
 The first and third John's are the same person as they have the common email "johnsmith@mail.com".
 The second John and Mary are different people as none of their email addresses are used by other accounts.
 We could return these lists in any order, for example the answer [['Mary', 'mary@mail.com'], ['John', 'johnnybravo@mail.com'],
 ['John', 'john00@mail.com', 'john_newyork@mail.com', 'johnsmith@mail.com']] would still be accepted.
 */

class Solution {
  func accountsMerge(_ accounts: [[String]]) -> [[String]] {
    var emailRelation = [String: Set<String>]()
    var emailToName = [String: String]()
    
    buildGraph(accounts, &emailRelation, &emailToName)
    
    return dfs(emailRelation, emailToName)
  }
  
  private func buildGraph(_ accounts: [[String]],_ emailRelation: inout [String: Set<String>],_ emailToName: inout [String: String]) {
    for account in accounts {
      let name = account[0]
      let emails = Array(account[1...])
      let first = emails[0]
      
      for email in emails {
        emailRelation[first, default: []].insert(email)
        emailRelation[email, default: []].insert(first)
        emailToName[email] = name
      }
    }
  }
  
  private func dfs(_ emailRelation: [String: Set<String>],_ emailToName: [String: String]) -> [[String]] {
    var result: [[String]] = []
    var visited = Set<String>()
    
    for email in emailRelation.keys {
      if !visited.contains(email) {
        visited.insert(email)
        
        var stack: [String] = []
        var emailList: [String] = []
        
        stack.append(email)
        
        while !stack.isEmpty {
          let em = stack.removeLast()
          emailList.append(em)
          
          for neigbor in emailRelation[em]! where !visited.contains(neigbor) {
            visited.insert(neigbor)
            stack.append(neigbor)
          }
        }
        
        result.append([emailToName[email]!] + emailList.sorted() )
        
      }
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
  
  func test1() {
    let accounts = [
      ["John", "a", "b"],
      ["John", "c"],
      ["John", "a", "d"],
      ["Mary", "e"],
      ["John", "c", "f"]
    ]
    
    let expected = [
      ["John", "a", "b", "d"],
      ["John", "c", "f"],
      ["Mary", "e"]
    ]
    let actual = solution.accountsMerge(accounts)
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


