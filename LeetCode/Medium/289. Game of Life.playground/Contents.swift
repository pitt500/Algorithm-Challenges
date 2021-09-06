import UIKit
import XCTest

class Solution {
    private let willLive = -1
    private let willDie = -2

    func gameOfLife(_ board: inout [[Int]]) {

        for i in 0..<board.count {
            for j in 0..<board[0].count {
                updateToTransitionState(row: i, col: j, board: &board)
            }
        }

        updateToFinalState(board: &board)
    }

    private func getLivesAround(row: Int, col: Int, board: inout [[Int]]) -> Int {
        var counter = 0

        for i in (row - 1)...(row + 1) {
            for j in (col - 1)...(col + 1) where i != row || j != col {
                var current = board[safe: i]?[safe: j] ?? 0

                //Transforming to right state before transition
                if current == willDie {
                    current = 1
                } else if current == willLive {
                    current = 0
                }

                counter += current
            }
        }

        return counter
    }

    private func updateToTransitionState(row: Int, col: Int, board: inout [[Int]]) {
        let value = board[row][col]
        let numLives = getLivesAround(row: row, col: col, board: &board)

        if value == 1 && (numLives < 2 || numLives > 3) {
            board[row][col] = willDie
        } else if value == 0 && numLives == 3  {
            board[row][col] = willLive
        }
    }

    private func updateToFinalState(board: inout [[Int]]) {
        for row in 0..<board.count {
            for column in 0..<board[0].count {
                if board[row][column] == willLive {
                    board[row][column] = 1
                } else if board[row][column] == willDie {
                    board[row][column] = 0
                }
            }
        }
    }
}

extension Array {
    subscript(safe index: Int) -> Element? {
        guard index >= self.startIndex && index < self.endIndex
        else {
            return nil
        }

        return self[index]
    }
}

class TestSolution: XCTestCase {
  var solution: Solution!
  
  override func setUp() {
    super.setUp()
    solution = Solution()
  }
  
  func test1() {
    let expected = [[0,0,0],[1,0,1],[0,1,1],[0,1,0]]
    var board = [[0,1,0],[0,0,1],[1,1,1],[0,0,0]]
    solution.gameOfLife(&board)

    assert(expected == board)
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
