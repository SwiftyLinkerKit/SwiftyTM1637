//
//  main.swift
//
//  Created by Helge Hess on 05.06.18.
//  Copyright © 2018 ZeeZide. All rights reserved.
//

import Foundation
import SwiftyGPIO
import SwiftyTM1637

let gpios   = SwiftyGPIO.GPIOs(for: .RaspberryPi3)

// E.g. a LK-Digi connected to the P4/P5 digital pins
let display = TM1637(clock: gpios[.P4]!, data: gpios[.P5]!)

display.turnOff()
display.brightness = .typical

while true {
  let cal = Calendar.current
  let now = cal.dateComponents([.hour, .minute, .second], from: Date())
  
  let hour   = now.hour   ?? 0
  let minute = now.minute ?? 0
  let second = now.second ?? 0
  
  let segment2 = SevenSegment(digit: hour % 10, dot: second % 2 != 0)
  
  display.show(s1: hour   / 10, s2: segment2,
               s3: minute / 10, s4: minute % 10)
  
  Thread.sleep(forTimeInterval: 0.5)
}
