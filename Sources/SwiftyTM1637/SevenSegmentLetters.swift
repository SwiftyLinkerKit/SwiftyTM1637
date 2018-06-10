//
//  SevenSegmentLetters.swift
//  SwiftyTM1637
//
//  Created by Helge Hess on 10.06.18.
//

import Foundation

public extension SevenSegment {
  
  public static let dash : SevenSegment = [ .middleDash ] // -

  public static let letters : [ Character : SevenSegment ] = [
    "A": SevenSegment(hexDigit: 0xA),
    "B": SevenSegment(hexDigit: 0xB),
    "C": SevenSegment(hexDigit: 0xC),
    "D": SevenSegment(hexDigit: 0xD),
    "E": SevenSegment(hexDigit: 0xE),
    "F": SevenSegment(hexDigit: 0xF),
    "G": SevenSegment(digit: 6),
    "H": [ .upperLeft,  .upperRight, .middleDash, .lowerLeft,  .lowerRight ],
    "I": [ .upperRight, .lowerRight ],
    "J": [ .upperRight, .lowerRight, .lowerDash  ],
    "K": [ .upperRight, .middleDash, .upperLeft,  .lowerLeft,  .lowerRight ],
    "L": [ .upperLeft,  .lowerLeft,  .lowerDash  ],
    "O": SevenSegment(digit: 0),
    "P": [ .upperLeft,  .upperDash,  .upperRight, .middleDash, .lowerLeft  ],
    "Q": SevenSegment(digit: 0, dot: true),
    "R": SevenSegment(hexDigit: 0xA),
    "S": [ .upperLeft,  .middleDash, .upperDash,  .lowerRight, .lowerDash  ],
    "T": [ .upperDash,  .upperRight, .lowerRight ],
    "U": [ .upperLeft,  .upperRight, .lowerLeft,  .lowerRight, .lowerDash  ],
    "V": [ .upperLeft,  .upperRight, .lowerLeft,  .lowerRight, .lowerDash  ],
    // W?
    "X": [ .upperRight, .middleDash, .upperLeft,  .lowerLeft,  .lowerRight ],
    "Y": [ .upperRight, .middleDash, .upperLeft,  .lowerRight ],
    "Z": [ .upperDash,  .upperRight, .middleDash, .lowerLeft,  .lowerDash  ],

    "a": SevenSegment(hexDigit: 0xA),
    "b": [ .upperLeft,  .middleDash, .lowerLeft,  .lowerRight, .lowerDash ],
    "c": [ .middleDash, .lowerLeft,  .lowerDash ],
    "d": [ .middleDash, .upperRight, .lowerLeft,  .lowerRight, .lowerDash ],
    "h": [ .upperRight, .middleDash, .lowerLeft,  .lowerRight ],
    "i": [ .lowerRight ],
    "n": [ .lowerLeft,  .middleDash, .lowerRight ],
    "o": [ .middleDash, .lowerLeft,  .lowerRight, .lowerDash  ],
    "u": [ .lowerLeft,  .lowerDash,  .lowerRight ],
    "v": [ .lowerLeft,  .lowerDash,  .lowerRight ],
  ]
}
