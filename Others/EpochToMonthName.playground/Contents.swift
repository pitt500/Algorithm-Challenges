import Foundation
import XCTest

/*
 
 Many software applications require a sense of time.
 In Unix, time is represented as the number of milliseconds since a
 particular reference point called the Epoch (January 1, 12:00AM, 1970),
 when milliseconds = 0.
 
 Create a class called “Date” which is initialized with
 single parameter: milliseconds.
 Then add the ability for this Date class to return the Month.
 */

class XDate {
  let milliseconds: Double
  var months = [
    "", "January", "February", "March",
    "April", "May", "June", "July",
    "August", "September", "November",
    "December"
  ]
  
  init(_ milliseconds: Double) {
    self.milliseconds = milliseconds
  }
  
  func getMonth() -> String {
    var currentMillisecs: Double = 0
    var year = 1970
    let aDay: Double = 86_400_000
    
    repeat {
      currentMillisecs += millisecondsForYear(year)
      year += 1
      
    } while currentMillisecs < milliseconds
    
    //Decrease year in 1 and current in one day to be in the last day of past year. (Dec 31)
    year -= 1
    currentMillisecs -= aDay
    
    //Loop until get target month
    var month = 12
    while currentMillisecs > milliseconds {
      currentMillisecs -= aDay * getNumberOfDays(month: month, year: year)
      month -= 1
    }
    
    
    return months[month + 1]
  }
  
  func millisecondsForYear(_ year: Int) -> Double {
    let yearsInMilli: Double = 31_536_000_000
    let aDay: Double = 86_400_000
    
    if isLeapYear(year: year) {
      return yearsInMilli + aDay
    }
    
    return yearsInMilli
  }
  
  func isLeapYear(year: Int) -> Bool {
    return (year%4 == 0 && !(year % 100 == 0)) || year % 400 == 0
  }
  
  func getNumberOfDays(month: Int, year: Int) -> Double {
    let days: [Double] = [-1, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    
    if month == 2 && isLeapYear(year: year) {
      return days[month] + 1
    }
    
    return days[month]
  }
}


//MARK: - Testing
class TestSolution: XCTestCase {

  func test1() {
    let date = XDate(1454000028837)
    let expected = "January"
    let actual = date.getMonth()
    
    XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
  }
  
  func test2() {
    let date = XDate(1)
    let expected = "January"
    let actual = date.getMonth()
    
    XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
  }

  func test3() {
    let date = XDate(1599628219977)
    let expected = "September"
    let actual = date.getMonth()
    
    XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
  }
  
  func test4() {
    let date = XDate(8345984903903)
    let expected = "June"
    let actual = date.getMonth()
    
    XCTAssertTrue(expected == actual, "\nexpected value is \(expected), but actual is \(actual)\n")
  }
  
  func test5() {
    let date = XDate(495892832999)
    let expected = "September"
    let actual = date.getMonth()
    
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
