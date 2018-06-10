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

