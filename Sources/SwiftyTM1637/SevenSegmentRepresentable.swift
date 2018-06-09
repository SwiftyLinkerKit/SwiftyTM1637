//
//  SevenSegmentRepresentable.swift
//  SwiftyTM1637
//
//  Created by Helge Hess on 07.06.18.
//

public protocol SevenSegmentRepresentable {
  
  var sevenSegmentValue : SevenSegment? { get }
  
}

extension SevenSegment : SevenSegmentRepresentable {

  public var sevenSegmentValue : SevenSegment? { return self }
  
}

extension Int : SevenSegmentRepresentable {

  public var sevenSegmentValue : SevenSegment? {
    guard (0...15).contains(self) else { return nil }
    return SevenSegment(hexDigit: self)
  }
  
}

public extension SevenSegment {
  
  public static let dash : SevenSegment = [ .middleDash ] // -

  public static let letters : [ Character : SevenSegment ] = [
    "O": SevenSegment(digit: 0),
    "A": SevenSegment(hexDigit: 0xA),
    "B": SevenSegment(hexDigit: 0xB),
    "C": SevenSegment(hexDigit: 0xC),
    "D": SevenSegment(hexDigit: 0xD),
    "E": SevenSegment(hexDigit: 0xE),
    "F": SevenSegment(hexDigit: 0xF),
    "S": [ .upperLeft,  .middleDash, .upperDash,  .lowerRight, .lowerDash  ],
    "X": [ .upperRight, .middleDash, .upperLeft,  .lowerLeft,  .lowerRight ],
    "Y": [ .upperRight, .middleDash, .upperLeft,  .lowerRight ],
    "Z": [ .upperDash,  .upperRight, .middleDash, .lowerLeft,  .lowerDash  ],

    "a": SevenSegment(hexDigit: 0xA),
    "b": [ .upperLeft,  .middleDash, .lowerLeft,  .lowerRight, .lowerDash ],
    "c": [ .middleDash, .lowerLeft,  .lowerDash ],
    "d": [ .middleDash, .upperRight, .lowerLeft,  .lowerRight, .lowerDash ],
    "h": [ .upperRight, .middleDash, .lowerLeft,  .lowerRight ],
    "n": [ .lowerLeft,  .middleDash, .lowerRight ],
    "o": [ .middleDash, .lowerLeft,  .lowerRight, .lowerDash  ],
  ]
}

extension Character : SevenSegmentRepresentable {
  
  public var sevenSegmentValue : SevenSegment? {
    if let s7 = SevenSegment.letters[self] { return s7 }
    if self == " " { return .off }
    
    // use uppercase version if available
    if let c  = String(self).uppercased().first,
       let s7 = SevenSegment.letters[c] { return s7 }
    
    // FIXME: add more!
    let utf8 = String(self).utf8
    guard utf8.count == 1, let c0 = utf8.first else { return nil }
    guard (48...57).contains(c0) else { return nil }
    return SevenSegment(hexDigit: Int(c0) - 48)
  }
  
}

