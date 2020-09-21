import Foundation
import XCTest

/*
 
 Given a string that contains only digits 0-9 and a target value,
 return all possibilities to add binary operators (not unary) +, -, or *
 between the digits so they evaluate to the target value.

 Example 1:

 Input: num = "123", target = 6
 Output: ["1+2+3", "1*2*3"]
 Example 2:

 Input: num = "232", target = 8
 Output: ["2*3+2", "2+3*2"]
 Example 3:

 Input: num = "105", target = 5
 Output: ["1*0+5","10-5"]
 Example 4:

 Input: num = "00", target = 0
 Output: ["0+0", "0-0", "0*0"]
 Example 5:

 Input: num = "3456237490", target = 9191
 Output: []
 */

class Solution {
    func addOperators(_ num: String, _ target: Int) -> [String] {
        guard !num.isEmpty else { return [] }
        
        var result = [String]()
        let num = Array(num)
        
        evaluateExpression(num, &result, "", 0, target, 0, 0)
        
        return result
    }
    
    func evaluateExpression(
        _ num: [Character],
        _ resultArray: inout [String],
        _ currentExpression: String,
        _ index: Int,
        _ target: Int,
        _ sum: Int,
        _ prev: Int
    ) {
        
        if index == num.count {
            if target == sum {
                resultArray.append(currentExpression)
            }
            
            return
        }
        
        var i = index
        
        while i < num.count {
            let stringValue = String(num[index...i])
            let value = Int(stringValue)!

            if index == 0 {
                evaluateExpression(num, &resultArray, String(value), i + 1, target, value, value)
            } else {
                evaluateExpression(num, &resultArray, currentExpression + "+" + String(value), i + 1, target, sum + value, value)
                evaluateExpression(num, &resultArray, currentExpression + "-" + String(value), i + 1, target, sum - value, -value)
                
                //sum - prev + prev*value revert the effect of previous changes to incorporate the multiplication
                evaluateExpression(num, &resultArray, currentExpression + "*" + String(value), i + 1, target, sum - prev + prev*value, prev*value)
            }
            
            //Avoid cases when due zero value, we lose part of the current expression, for example:
            /*
                num=1000 and target = 10

                At the end, the returned value is ["10+0+0","10+0-0","10+0*0","10-0+0","10-0-0","10-0*0","10+0","10-0"]

                If you look last two results, we are missing a 0 value, this is because 10 + 0 = 10 and match the criteria
                without evaluate the rest of the expression. That approach is discarded.
            */
            if value == 0 { break }
            
            i += 1
        }
        
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
        let expected = ["1*0+5+0","1*0+5-0","10-5+0","10-5-0"]
        let actual = solution.addOperators("1050", 5)
        
        XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
    }
    
    func test2() {
        let expected = ["2+3*2", "2*3+2"]
        let actual = solution.addOperators("232", 8)
        
        XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
    }
    
    func test3() {
        let expected = [
            "1+2-3-4+56-7", "1+2+34-5+6+7", "1-2+3-4+5+6*7",
            "1*2-3+45-6+7", "1*2*34-5*6+7", "1+23+4*5-6+7",
            "1-23+4+56+7", "1*23+4+5+6+7", "1*23-4*5+6*7",
            "1*23*4-5-6*7", "1*23-45+67"
        ]
        let actual = solution.addOperators("1234567", 45)
        
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


