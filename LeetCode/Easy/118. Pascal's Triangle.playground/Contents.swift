import UIKit
import XCTest

class Solution {
    func generate(_ numRows: Int) -> [[Int]] {

        // Base case
        if numRows == 1 {
            return [[1]]
        } else if numRows == 2 {
            return [[1], [1,1]]
        }

        //Get previous result
        var result = generate(numRows - 1)

        let lastRow = result.last ?? []
        var newRow: [Int] = []

        //Add first one
        newRow.append(1)

        for i in 0..<lastRow.count - 1 {
            newRow.append(lastRow[i] + lastRow[i+1])
        }

        //Add last one
        newRow.append(1)

        result.append(newRow)

        return result
    }

}

class TestSolution: XCTestCase {
    var solution: Solution!

    override func setUp() {
        super.setUp()
        solution = Solution()
    }

    func test1() {
        let expected = [[1],[1,1]]
        let actual = solution.generate(2)

        print(expected, actual)
        assert(expected == actual)
    }

    func test2() {
        let expected = [[1],[1,1],[1,2,1],[1,3,3,1],[1,4,6,4,1]]
        let actual = solution.generate(5)

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
