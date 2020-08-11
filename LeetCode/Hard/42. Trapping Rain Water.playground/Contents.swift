import Foundation
import XCTest

class Solution {
  
  //MARK: - My Solution
  func trap_DP(_ height: [Int]) -> Int {
    
    guard height.count > 2 else {
      return 0
    }
    
    var water = 0
    var leftMax = [Int](repeating: 0, count: height.count)
    leftMax[0] = height[0]
    
    for i in 1..<height.count {
      leftMax[i] = max(height[i], leftMax[i - 1])
    }
    
    var rightMax = [Int](repeating: 0, count: height.count)
    rightMax[height.count - 1] = height[height.count - 1]
    
    for i in stride(from: height.count - 2, to: -1, by: -1) {
      rightMax[i] = max(height[i], rightMax[i + 1])
    }
    
    for i in 0..<height.count {
      water += min(leftMax[i], rightMax[i]) - height[i]
    }
    
    return water
  }
  
  //MARK: - Better Solutions
  func trap_twoPointers(_ height: [Int]) -> Int {
    var left = 0
    var right = height.count - 1
    var lmax = 0
    var rmax = 0
    var water = 0
    
    while left < right {
      if height[left] < height[right] {
        height[left] >= lmax ? (lmax = height[left]) :  (water += lmax - height[left])
        left += 1
      } else {
        height[right] >= rmax ? (rmax = height[right]) : (water += rmax - height[right])
        right -= 1
      }
    }
    
    return water
  }
  
  func trap_stack(_ height: [Int]) -> Int {
    
    //Save indices of height in the stack
    var stack = [Int]()
    var water = 0
    var i = 0
    let numBars = height.count
    
    while i < numBars {
      while !stack.isEmpty && height[i] > height[stack.last!] {
        let last = stack.removeLast()
        
        if stack.isEmpty {
          break
        }
        
        let distance = i - stack.last! - 1
        let heightContainingWater = min(height[i], height[stack.last!]) - height[last]
        
        water += distance * heightContainingWater
      }
      stack.append(i)
      i += 1
    }
    
    return water
  }
}


//MARK: - Tests

class TestSolution: XCTestCase {
  var solution: Solution!
  
  override func setUp() {
    super.setUp()
    self.solution = Solution()
  }
  
  func testDP() {
    let expected = 6
    let actual = solution.trap_DP([0,1,0,2,1,0,1,3,2,1,2,1])
    
    XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
  }
  
  func testStack() {
    let expected = 6
    let actual = solution.trap_stack([0,1,0,2,1,0,1,3,2,1,2,1])
    
    XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
  }
  
  func testTwoPointers() {
    let expected = 6
    let actual = solution.trap_twoPointers([0,1,0,2,1,0,1,3,2,1,2,1])
    
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

