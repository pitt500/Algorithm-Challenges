import Foundation

class Solution {
    func isAlienSorted(_ words: [String], _ order: String) -> Bool {
        
        //Create a dictionary with the order value of each letter
        var orderDict: [Character: Int] = [:]
        for (index, letter) in order.enumerated() {
            orderDict[letter] = index
        }
        
        for i in 0..<words.count - 1 {
            //Checking adjacent words
            let word1 = [Character](words[i])
            let word2 = [Character](words[i + 1])
            
            if !isOrderValid(word1, word2, orderDict) {
                // Invalid order, or next word is larger than previous one.
                return false
            }
        }
        
        return true
    }
    
    private func isOrderValid(_ word1: [Character],_ word2: [Character], _ orderDict: [Character: Int]) -> Bool {
        let minLength = min(word1.count, word2.count)
        for i in 0..<minLength where word1[i] != word2[i] {
            
            // Checking if letters are different.
            // If they are and order is correct, return true
            // Otherwise, false
            return orderDict[word1[i]]! <= orderDict[word2[i]]!
        }
        
        // Found same letters, checking length
        return word1.count <= word2.count
    }
}

let solution = Solution()
solution.isAlienSorted(["kuvp","q"], "ngxlkthsjuoqcpavbfdermiywz")
solution.isAlienSorted(["word","world","row"], "worldabcefghijkmnpqstuvxyz")
