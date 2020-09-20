import Foundation
import XCTest

/*
 
 Design a data structure that supports adding new words and finding if a string matches any previously added string.
 
 Implement the WordDictionary class:
 WordDictionary() Initializes the object.
 void addWord(word) Adds word to the data structure, it can be matched later.
 bool search(word) Returns true if there is any string in the data structure
 that matches word or false otherwise. word may contain dots '.' where dots can be matched with any letter.
 
 Example:
     WordDictionary wordDictionary = new WordDictionary();
     wordDictionary.addWord("bad");
     wordDictionary.addWord("dad");
     wordDictionary.addWord("mad");
     wordDictionary.search("pad"); // return False
     wordDictionary.search("bad"); // return True
     wordDictionary.search(".ad"); // return True
     wordDictionary.search("b.."); // return True
 
 Constraints:
    - 1 <= word.length <= 500
    - word in addWord consists lower-case English letters.
    - word in search consist of  '.' or lower-case English letters.
    - At most 50000 calls will be made to addWord and search.
 */

class TrieNode {
    var key: Character?
    weak var parent: TrieNode?
    var children: [Character: TrieNode] = [:]
    var isEnding = false
    
    init(key: Character? = nil, parent: TrieNode? = nil) {
        self.key = key
        self.parent = parent
    }
}

class WordDictionary {
    
    private var root: TrieNode

    /** Initialize your data structure here. */
    init() {
        self.root = TrieNode()
    }
    
    /** Adds a word into the data structure. */
    func addWord(_ word: String) {
        var current = root
        
        for letter in word {
            if current.children[letter] == nil {
                current.children[letter] = TrieNode(key: letter, parent: current)
            }
            
            current = current.children[letter]!
        }
        
        current.isEnding = true
    }
    
    /** Returns if the word is in the data structure. A word could contain the dot character '.' to represent any one letter. */
    func search(_ word: String) -> Bool {
        let word = Array(word)
        return search(word, 0, root)
    }
    
    private func search(_ word: [Character],_ index: Int,_ node: TrieNode) -> Bool {
        if index == word.count {
            return node.isEnding
        }
        
        if word[index] == "." {
            //Check all branches until get a valid response
            for key in node.children.keys {
                let child = node.children[key]!

                if search(word, index + 1, child) {
                    return true
                }

            }
        } else {
            if let child = node.children[word[index]] {
                return search(word, index + 1, child)
            } else {
                return false
            }
        }
        
        return false
    }
    
}

//MARK: - Testing
class TestSolution: XCTestCase {
    var solution: WordDictionary!
    
    override func setUp() {
        super.setUp()
        self.solution = WordDictionary()
        
        solution.addWord("bad")
        solution.addWord("mad")
        solution.addWord("dad")
        solution.addWord("daddy")
    }
    
    func test1() {
        let expected = true
        let actual = solution.search(".ad")
        
        XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
    }
    
    func test2() {
        let expected = false
        let actual = solution.search("addy")
        
        XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
    }
    
    func test3() {
      let expected = true
      let actual = solution.search("d...y")
      
      XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
    }
    
    func test4() {
      let expected = true
      let actual = solution.search("mad")
      
      XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
    }
    
    func test5() {
      let expected = true
      let actual = solution.search("m..")
      
      XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
    }
    
    func test6() {
        let expected = false
      let actual = solution.search("m...")
      
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


