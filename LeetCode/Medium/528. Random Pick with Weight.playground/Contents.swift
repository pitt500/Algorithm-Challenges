import UIKit
/*
 Given an array w of positive integers, where w[i] describes the weight of index i(0-indexed),
 write a function pickIndex which randomly picks an index in proportion to its weight.

 For example, given an input list of values w = [2, 8], when we pick up a number out of it,
 the chance is that 8 times out of 10 we should pick the number 1 as the answer since it's
 the second element of the array (w[1] = 8).

 */

class Solution {
  
  private var acc: [Int]
  
  init(_ w: [Int]) {
    self.acc = w
    
    for i in 1..<w.count {
      self.acc[i] += self.acc[i - 1]
    }
  }
  
  func pickIndex() -> Int {
    
    let rand = Int.random(in: 1...acc.last!)
    var start = 0
    var end = acc.count - 1
    
    while start < end {
      let mid = (start + end) >> 1
      acc[mid] < rand ? (start = mid + 1) : ( end = mid)
    }
    
    return start
  }
  
}

//MARK: - Testing
let input = [3, 12, 1, 4, 7]
let solution = Solution(input)

var result: [Int] = []

for _ in 1...1000 {
  result.append(solution.pickIndex())
}

let sum = input.reduce(0, { $0 + $1 })


for i in 0..<input.count {
  let totalIndex = result.filter({ $0 == i }).count
  print("Percentage of index \(i) is \(totalIndex/sum)%")
}
