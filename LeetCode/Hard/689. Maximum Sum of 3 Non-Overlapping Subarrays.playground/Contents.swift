import Foundation
import XCTest

/*
 
 In a given array nums of positive integers, find three non-overlapping subarrays with maximum sum.

 Each subarray will be of size k, and we want to maximize the sum of all 3*k entries.

 Return the result as a list of indices representing the starting position of each interval (0-indexed).
 If there are multiple answers, return the lexicographically smallest one.

 Example:

 Input: [1,2,1,2,6,7,5,1], 2
 Output: [0, 3, 5]
 Explanation: Subarrays [1, 2], [2, 6], [7, 5] correspond to the starting indices [0, 3, 5].
 We could have also taken [2, 1], but an answer of [1, 3, 5] would be lexicographically larger.
  

 Note:

 nums.length will be between 1 and 20000.
 nums[i] will be between 1 and 65535.
 k will be between 1 and floor(nums.length / 3).
 */

class Solution {
    func maxSumOfThreeSubarrays(_ nums: [Int], _ k: Int) -> [Int] {
        let subarraysSum = subArrays(nums, k)
        return getMaxSubArray(subarraysSum, k)
    }
    
    private func subArrays(_ nums: [Int], _ k: Int) -> [Int] {
        var subarraysSum = [Int](repeating: 0, count: nums.count - k + 1)
        var currentSum = 0
        
        for i in 0..<nums.count {
            currentSum += nums[i]
            
            if i >= k {
                currentSum -= nums[i - k]
            }
            
            if i >= k - 1 {
                subarraysSum[i - k + 1] = currentSum
            }
        }
        
        return subarraysSum
    }
    
    private func getMaxSubArray(_ subarraySum: [Int], _ k: Int) -> [Int] {
        let left = getLeftIndices(subarraySum)
        let right = getRightIndices(subarraySum)
        
        return getFinalResult(subarraySum, left, right, k)
    }
    
    private func getLeftIndices(_ subarraySum: [Int]) -> [Int] {
        var left = [Int](repeating: -1, count: subarraySum.count)
        var bestIndex = 0
        
        for i in 0..<subarraySum.count {
            if subarraySum[i] > subarraySum[bestIndex] {
                bestIndex = i
            }
            
            left[i] = bestIndex
        }
        
        return left
    }
    
    private func getRightIndices(_ subarraySum: [Int]) -> [Int] {
        var right = [Int](repeating: -1, count: subarraySum.count)
        var bestIndex = subarraySum.count - 1
        
        for i in stride(from: subarraySum.count - 1, to: -1, by: -1) {
            if subarraySum[i] >= subarraySum[bestIndex] {
                bestIndex = i
            }
            
            right[i] = bestIndex
        }
        
        return right
    }
    
    private func getFinalResult(_ subarraySum: [Int],_ left: [Int], _ right: [Int],_ k: Int) -> [Int] {
        var result = [Int]()
        
        for i in k..<(subarraySum.count - k) {
            let l = left[i - k]
            let r = right[i + k]
            
            if  result.isEmpty ||
                subarraySum[l] + subarraySum[i] + subarraySum[r] >
                subarraySum[result[0]] + subarraySum[result[1]] + subarraySum[result[2]] {
                result = [l, i, r]
            }
        }
        
        
        return result
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
        let expected = [0,2,4]
        let actual = solution.maxSumOfThreeSubarrays([1,2,1,2,1,2,1,2,1], 2)
        
        XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
    }
    
    func test2() {
        let expected = [0,3,5]
        let actual = solution.maxSumOfThreeSubarrays([1,2,1,2,6,7,5,1], 2)
        
        XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
    }
    
    func test3() {
        let expected = [1,4,7]
        let actual = solution.maxSumOfThreeSubarrays([1,2,1,2,6,7,5,1,5,6], 3)
        
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


