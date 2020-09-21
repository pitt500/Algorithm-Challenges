import Foundation
import XCTest

/*
 
 Given a file and assume that you can only read the file using a given method read4, implement a method to read n characters.

  

 Method read4:

 The API read4 reads 4 consecutive characters from the file, then writes those characters into the buffer array buf.

 The return value is the number of actual characters read.

 Note that read4() has its own file pointer, much like FILE *fp in C.

 Definition of read4:

     Parameter:  char[] buf4
     Returns:    int

 Note: buf4[] is destination not source, the results from read4 will be copied to buf4[]
 
 Example:
 Input: file = "leetcode", n = 5
 Output: 5
 Explanation: After calling your read method, buf should contain "leetc". We read a total of 5 characters from the file, so return 5.
 */

/**
 * The read4 API is defined in the parent class Reader4.
 *     func read4(_ buf4: inout [Character]) -> Int;
 */

class Reader4 {
    private var index = 0
    
    func read4(_ buf4: inout [Character]) -> Int {
        if index + 4 < buf4.count {
            return 4
        }
        
        return buf4.count - index
    }
}

class Solution : Reader4 {
    /**
     * @param buf Destination buffer
     * @param n   Number of characters to read
     * @return    The number of actual characters read
     */
    var cache = [Character]()
    var eof = false
    
    func read(_ buf: inout [Character], _ n: Int) -> Int {
        var copiedCharacters = 0
        var readCharacters = 4
        
        while copiedCharacters < n && !cache.isEmpty {
            buf[copiedCharacters] = cache.removeFirst()
            copiedCharacters += 1
        }
        
        var buf4 = [Character](repeating: "-", count: 4)
        
        while copiedCharacters < n && !eof {
            //Read 4 by 4 until last chars < 4
            readCharacters = read4(&buf4)
            eof = readCharacters < 4
            
            let numElements = min(readCharacters, n - copiedCharacters)
            var index = 0
            
            while index < numElements {
                //buf stores the global process, and buf4 the local
                buf[copiedCharacters] = buf4[index]
                copiedCharacters += 1
                index += 1
            }
            
            while index < readCharacters {
                cache.append(buf4[index])
                index += 1
            }
        }
        
        return copiedCharacters
    }
}

