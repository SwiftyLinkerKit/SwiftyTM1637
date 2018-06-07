# SwiftyTM1637

![Swift3](https://img.shields.io/badge/swift-3-blue.svg)
![Swift4](https://img.shields.io/badge/swift-4-blue.svg)
![tuxOS](https://img.shields.io/badge/os-tuxOS-green.svg?style=flat)
<a href="https://slackpass.io/swift-arm"><img src="https://img.shields.io/badge/Slack-swift/arm-red.svg?style=flat"/></a>
<a href=""><img src="https://travis-ci.org/AlwaysRightInstitute/SwiftyTM1637.svg?branch=develop" /></a>

A 
[SwiftyGPIO](https://github.com/uraimo/SwiftyGPIO)
based driver for the TM1637 7-segment chipset,
as used in the
[LK-Digi](http://www.linkerkit.de/index.php?title=LK-Digi)
[LinkerKit](http://www.linkerkit.de)
element.

The module is heavily inspired by the Python code example shown at the
[LK-Digi](http://www.linkerkit.de/index.php?title=LK-Digi)
wiki.

## Example

A simple digital clock:

```swift
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
```


### Who

**SwiftyTM1637** is brought to you by
[AlwaysRightInstitute](http://www.alwaysrightinstitute.com).
We like feedback, GitHub stars, cool contract work,
presumably any form of praise you can think of.

There is a channel on the [Swift-ARM Slack](http://swift-arm.noze.io).
