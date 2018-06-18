//
//  SevenSegment.swift
//  TestGPIO
//
//  Created by Helge Hess on 06.06.18.
//  Copyright © 2018 ZeeZide. All rights reserved.
//

public struct SevenSegment : OptionSet, CustomStringConvertible {
  
  public let rawValue : UInt8
  
  public static let upperDash  = SevenSegment(rawValue: 1 << 0)
  public static let upperRight = SevenSegment(rawValue: 1 << 1)
  public static let lowerRight = SevenSegment(rawValue: 1 << 2)
  public static let lowerDash  = SevenSegment(rawValue: 1 << 3)
  public static let lowerLeft  = SevenSegment(rawValue: 1 << 4)
  public static let upperLeft  = SevenSegment(rawValue: 1 << 5)
  public static let middleDash = SevenSegment(rawValue: 1 << 6)

  public static let dot        = SevenSegment(rawValue: 1 << 7)
  public static let off        = SevenSegment(rawValue: 0)

  public init(rawValue: UInt8) {
    self.rawValue = rawValue
  }
  
  public init(digit: Int, dot: Bool = false) {
    if digit < 0 || digit > 9 {
      assert(digit >= 0 && digit <= 9, "digit out of range (0...9): \(digit)")
      self.init(rawValue: SevenSegment.off.rawValue)
    }
    else {
      self.init(hexDigit: digit, dot: dot)
    }
  }
  
  public init(hexDigit digit: Int, dot: Bool = false) {
    if digit < 0 || digit > 15 {
      assert(digit >= 0 && digit <= 15,
             "digit out of range (0...15): \(digit)")
      self.init(rawValue: SevenSegment.off.rawValue)
    }
    else if !dot {
      self.init(rawValue: SevenSegment.hexDigits[digit].rawValue)
    }
    else {
      self.init(rawValue: SevenSegment.hexDigits[digit].rawValue
                        + SevenSegment.dot.rawValue)
    }
  }

  public var dotOn : SevenSegment {
    var s = self
    s.insert(.dot)
    return s
  }
  public var dotOff : SevenSegment {
    var s = self
    s.remove(.dot)
    return s
  }

  public var isDisplaying : Bool { return rawValue != 0 }
  
  public var characterRepresentation : Character {
    let base = self.dotOff
    if base == .off { return " " }
    
    // TODO: support many more (left vertical box line etc)
    switch base {
      case .middleDash: return "-"
      case .lowerDash:  return "_"
      default: break
    }
    
    for i in 0..<16 {
      let hd = SevenSegment.hexDigits[i]
      if base == hd {
        let s = String(i, radix: 16, uppercase: true)
        return s.first!
      }
    }
    
    return " "
  }
  
  public var description: String {
    var ms = "<7Seg: "
    
    ms += "0x"
    ms += String(rawValue, radix: 16, uppercase: true)

    let c = characterRepresentation
    if c != " " {
      ms += " "
      ms += String(characterRepresentation)
      if contains(.dot) { ms += "." }
    }
    else if contains(.dot) {
      ms += " ."
    }
    
    ms += ">"
    return ms
  }
}
