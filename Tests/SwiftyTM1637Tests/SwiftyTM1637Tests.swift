import XCTest
@testable import SwiftyTM1637

class SwiftyTM1637Tests: XCTestCase {
  
  func testSevenSegment() {
    let HexDigits : [ UInt8 ] = [
      0x3f, 0x06, 0x5b, 0x4f, 0x66, 0x6d, 0x7d, 0x07,
      0x7f, 0x6f, 0x77, 0x7c, 0x39, 0x5e, 0x79, 0x71
    ]
    
    for i in 0...15 {
      let segment = SevenSegment(hexDigit: i)
      XCTAssertEqual(segment.rawValue, HexDigits[i],
                     "binary values for digit \(i) do not match")
    }
  }
  
  func testSevenSegmentWithDot() {
    let HexDigits : [ UInt8 ] = [
      0x3f, 0x06, 0x5b, 0x4f, 0x66, 0x6d, 0x7d, 0x07,
      0x7f, 0x6f, 0x77, 0x7c, 0x39, 0x5e, 0x79, 0x71
    ]
    
    for i in 0...15 {
      let segment = SevenSegment(hexDigit: i, dot: true)
      XCTAssertEqual(segment.rawValue, HexDigits[i] + 0x80,
                     "binary values for digit \(i) do not match")
    }
  }

  static var allTests = [
    ( "testSevenSegment",        testSevenSegment        ),
    ( "testSevenSegmentWithDot", testSevenSegmentWithDot ),
  ]
}
