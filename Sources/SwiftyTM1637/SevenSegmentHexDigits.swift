//
//  SevenSegmentHexDigits.swift
//  SwiftyTM1637
//
//  Created by Helge Hess on 07.06.18.
//

// TODO: Alphabet, maybe this one?:
//   https://gist.github.com/rwaldron/0dd696800d2a09786ec2

public extension SevenSegment {
  
  public static let hexDigits : [ SevenSegment ] = [
    [ .upperDash,  .upperLeft,  .upperRight,   // 0
      .lowerLeft,  .lowerRight, .lowerDash ],
    [ .upperRight, .lowerRight            ],   // 1
    [ .upperDash,  .upperRight, .middleDash, .lowerLeft,  .lowerDash ], // 2
    [ .upperDash,  .upperRight, .middleDash, .lowerRight, .lowerDash ], // 3
    [ .upperLeft,  .upperRight, .middleDash, .lowerRight ], // 4
    [ .upperDash,  .upperLeft,  .middleDash, .lowerRight, .lowerDash ], // 5
    [ .upperDash,  .upperLeft,  .middleDash,
      .lowerLeft,  .lowerRight, .lowerDash ],  // 6
    [ .upperDash,  .upperRight, .lowerRight ], // 7
    [ .upperDash,  .upperLeft,  .upperRight, .middleDash,
      .lowerLeft,  .lowerRight, .lowerDash ],  // 8
    [ .upperDash,  .upperLeft,  .upperRight, .middleDash,
      .lowerRight, .lowerDash ],               // 9
    [ .upperDash,  .upperLeft,  .upperRight, .middleDash,
      .lowerRight, .lowerLeft ],               // A
    [ .upperLeft,  .middleDash, .lowerLeft,  .lowerRight, .lowerDash ], // B
    [ .upperDash,  .upperLeft,  .lowerLeft,  .lowerDash ], // C
    [ .upperRight, .middleDash, .lowerLeft,  .lowerRight, .lowerDash ], // D
    [ .upperDash,  .upperLeft,  .middleDash, .lowerLeft,  .lowerDash ], // E
    [ .upperDash,  .upperLeft,  .middleDash, .lowerLeft ]  // F
  ]
}
