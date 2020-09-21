import Foundation
import XCTest

/*
 
 Given a characters array tasks, representing the tasks a CPU needs to do, where each letter represents a different task.
 Tasks could be done in any order. Each task is done in one unit of time. For each unit of time,
 the CPU could complete either one task or just be idle.
 
 However, there is a non-negative integer n that represents the cooldown period between two same tasks (the same letter in the array),
 that is that there must be at least n units of time between any two same tasks.
 
 Return the least number of units of times that the CPU will take to finish all the given tasks.
 
 Example 1:
 Input: tasks = ["A","A","A","B","B","B"], n = 2
 Output: 8
 Explanation:
 A -> B -> idle -> A -> B -> idle -> A -> B
 There is at least 2 units of time between any two same tasks.
 
 
 Example 2:
 Input: tasks = ["A","A","A","B","B","B"], n = 0
 Output: 6
 Explanation: On this case any permutation of size 6 would work since n = 0.
 ["A","A","A","B","B","B"]
 ["A","B","A","B","A","B"]
 ["B","B","B","A","A","A"]
 ...
 And so on.
 
 
 Example 3:
 Input: tasks = ["A","A","A","A","A","A","B","C","D","E","F","G"], n = 2
 Output: 16
 Explanation:
 One possible solution is
 A -> B -> C -> A -> D -> E -> A -> F -> G -> A -> idle -> idle -> A -> idle -> idle -> A
 
 Constraints:
     1 <= task.length <= 104
     tasks[i] is upper-case English letter.
     The integer n is in the range [0, 100].
 */

typealias Task = Character

class Solution {
    
    func leastInterval(_ tasks: [Task], _ n: Int) -> Int {
        guard n > 0 else { return tasks.count }
        
        let taskFrequency = getTaskFrequency(tasks)
        let maxFrequency = taskFrequency[0].1
        /*
            If task A is the most frequent, then the max idle time required is:
            (maxFrequency - 1)*n = (5-1)*n = 4*n
            Assuming n = 2 -> max idle time = 8
            [A][][][A][][][A][][][A][][][A]
        */
        var idleTime = (maxFrequency - 1)*n
        
        //Decreasing idle time with other tasks frequencies
        for i in 1..<taskFrequency.count {
            idleTime -= min(maxFrequency - 1, taskFrequency[i].1)
        }
        
        //min could only be 0
        idleTime = max(0, idleTime)
        
        return tasks.count + idleTime
    }
    
    private func getTaskFrequency(_ tasks: [Task]) -> [(Task, Int)] {
        var dict = [Task: Int]()
        
        tasks.forEach { dict[$0, default: 0] += 1 }
        dict.sorted(by: { $0.value > $1.value })
        
        return dict.sorted(by: { $0.value > $1.value })
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
        let expected = 16
        let actual = solution.leastInterval(["A","A","A","A","A","A","B","C","D","E","F","G"], 2)
        
        XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
    }
    
    func test2() {
        let expected = 8
        let actual = solution.leastInterval(["A","A","A","B","B","B"], 2)
        
        XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
    }

    func test3() {
        let expected = 6
        let actual = solution.leastInterval(["A","A","A","B","B","B"], 0)
        
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


