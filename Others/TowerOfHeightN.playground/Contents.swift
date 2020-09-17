import Foundation
import XCTest

/*
 In how many ways we can build a tower of height N and width 3?. From blocks 3x1, 3x2, 3x3.
 
 Example:
 Input: 2
    X X X
    X X X
 output: 2
 Explanation: 2 of 3x1 blocks and 1 of 3x2 can make a tower of height 2
 
 */

class Solution {
    func waysOfBuildTower(_ n: Int) -> Int {
        var cache: [Int: Int] = [:]
        return helper(n, &cache)
    }
    
    private func helper(_ n: Int,_ cache: inout [Int: Int]) -> Int {
        if n < 1 { return 0 }
        if n == 1 || n == 2 { return n }
        if n == 3 { return 5 }
        
        if let cached = cache[n] {
            return cached
        }
        
        cache[n] = helper(n - 3, &cache) + helper(n - 2, &cache) + helper(n - 1, &cache)
        
        return cache[n]!
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
        let expected = 2
        let actual = solution.waysOfBuildTower(2)
        
        XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
    }
    
    func test2() {
        let expected = 2406963230636117244
        let actual = solution.waysOfBuildTower(70)
        
        XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
    }
    
    func test3() {
        let expected = 140928
        let actual = solution.waysOfBuildTower(20)
        
        XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
    }
    
    func test4() {
        let expected = 318
        let actual = solution.waysOfBuildTower(10)
        
        XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
    }
    
    func test5() {
        let expected = 28
        let actual = solution.waysOfBuildTower(6)
        
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





