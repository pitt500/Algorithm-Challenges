import Foundation

class Solution {
    func kClosest(_ points: [[Int]], _ K: Int) -> [[Int]] {
        let sortedPoints = points.sorted { $0[0]*$0[0] + $0[1]*$0[1] < $1[0]*$1[0] + $1[1]*$1[1] }
        return Array(sortedPoints.prefix(K))
    }
}

let points = [[3,3],[5,-1],[-2,4]]
let kValues = 2

let sol = Solution()
sol.kClosest(points, kValues)
