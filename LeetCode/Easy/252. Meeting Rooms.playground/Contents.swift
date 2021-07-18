import UIKit
import XCTest

class Solution {
    func canAttendMeetings(_ intervals: [[Int]]) -> Bool {
        let sortedIntervals = intervals.sorted(by: { $0[0] < $1[0] })
        var minStart = Int.min
        var maxEnd = Int.min

        for interval in sortedIntervals {
            let startIsOverlapped = minStart < interval[0] && interval[0] < maxEnd
            let endIsOverlapped =  minStart < interval[1] && interval[1] < maxEnd

            if startIsOverlapped || endIsOverlapped {
                return false
            }

            minStart = min(interval[0], minStart)
            maxEnd = max(interval[1], maxEnd)
        }

        return true
    }
}

/*
 Steps:
 - Sorting by start date
 - Iterate over array to identify overlaps
 */

class TestSolution: XCTestCase {
    var solution: Solution!

    override func setUp() {
        super.setUp()
        solution = Solution()
    }

    func testOverlapped() {
        let expected = false
        let actual = solution.canAttendMeetings([[0,30],[5,10],[15,20]])

        assert(expected == actual)
    }

    func testPersonCanAttend() {
        let expected = true
        let actual = solution.canAttendMeetings([[7,10],[2,4], [5,6]])

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
