import Foundation
import XCTest

/*
 On a single threaded CPU, we execute some functions.  Each function has a unique id between 0 and N-1.

 We store logs in timestamp order that describe when a function is entered or exited.

 Each log is a string with this format: "{function_id}:{"start" | "end"}:{timestamp}".
 For example, "0:start:3" means the function with id 0 started at the beginning of timestamp 3.
 "1:end:2" means the function with id 1 ended at the end of timestamp 2.

 A function's exclusive time is the number of units of time spent in this function.
 Note that this does not include any recursive calls to child functions.

 The CPU is single threaded which means that only one function is being executed at a given time unit.

 Return the exclusive time of each function, sorted by their function id.
 
 
 Input:
 n = 2
 logs = ["0:start:0","1:start:2","1:end:5","0:end:6"]
 
 Output: [3, 4]
 
 Explanation:
 Function 0 starts at the beginning of time 0, then it executes 2 units of time and reaches the end of time 1.
 Now function 1 starts at the beginning of time 2, executes 4 units of time and ends at time 5.
 Function 0 is running again at the beginning of time 6, and also ends at the end of time 6, thus executing for 1 unit of time.
 So function 0 spends 2 + 1 = 3 units of total time executing, and function 1 spends 4 units of total time executing.
 
 Note:
 1 <= n <= 100
 Two functions won't start or end at the same time.
 Functions will always log when they exit.
 */

enum Operation: String {
  case start
  case end
}

struct Process {
  let id: Int
  let op: Operation
  var time: Int
}

class Solution {
  func exclusiveTime(_ n: Int, _ logs: [String]) -> [Int] {
    let processes = logs.map { convertToProcess($0) }
    
    return getExclusiveTime(processes, n)
  }
  
  private func getExclusiveTime(_ processes: [Process], _ n: Int) -> [Int] {
    var total = [Int](repeating: 0, count: n)
    var stack: [(process: Process, totalTime: Int)] = [(processes[0], 0)]
    var current = processes[0]
    
    for newProcess in processes[1...] {
      if newProcess.op == .start {
        stack.append((current, newProcess.time))
        total[current.id] += newProcess.time - current.time
        
        current = newProcess
      } else {
        let diffTime = newProcess.time - current.time + 1
        total[current.id] += diffTime
        
        if let last = stack.popLast() {
          current = last.process
          current.time = newProcess.time + 1
        } else {
          break
        }
      }
      
    }
    
    return total
  }
  
  private func convertToProcess(_ string: String) -> Process {
    let array = string.components(separatedBy: ":")
    
    return Process(id: Int(array[0])!, op: Operation(rawValue: array[1])!, time: Int(array[2])!)
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
    let expected = [1,1,2]
    let actual = solution.exclusiveTime(3, ["0:start:0","0:end:0","1:start:1","1:end:1","2:start:2","2:end:2","2:start:3","2:end:3"])
    
    XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
  }
  
  func test2() {
    let expected = [5,4,4]
    let actual = solution.exclusiveTime(3, ["0:start:0","1:start:2", "1:end:5", "2:start:6","2:end:9","0:end:12"])
    
    XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
  }
  
  func test3() {
    let expected = [8]
    let actual = solution.exclusiveTime(1, ["0:start:0","0:start:2","0:end:5","0:start:6","0:end:6","0:end:7"])
    
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



