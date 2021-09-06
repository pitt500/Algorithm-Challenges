import UIKit
import XCTest

class Solution {
    func getRow(_ rowIndex: Int) -> [Int] {
        // Base case
        if rowIndex == 0 {
            return [1]
        } else if rowIndex == 1 {
            return [1,1]
        }

        //Get previous result
        var result = getRow(rowIndex - 1)
        var newRow: [Int] = []

        //Add first one
        newRow.append(1)

        for i in 0..<result.count - 1 {
            newRow.append(result[i] + result[i+1])
        }

        //Add last one
        newRow.append(1)

        return newRow
    }
}

class TestSolution: XCTestCase {
    var solution: Solution!

    override func setUp() {
        super.setUp()
        solution = Solution()
    }

    func test1() {
        let expected = [1,1]
        let actual = solution.getRow(1)

        print(expected, actual)
        assert(expected == actual)
    }

    func test2() {
        let expected = [1,4,6,4,1]
        let actual = solution.getRow(4)

        print(expected, actual)
        assert(expected == actual)
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
