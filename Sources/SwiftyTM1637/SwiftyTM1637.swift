//
//  TM1637.swift
//  TestGPIO
//
//  Created by Helge Hess on 05.06.18.
//  Copyright © 2018 ZeeZide. All rights reserved.
//

import class SwiftyGPIO.GPIO

#if os(Linux)
  import func      Glibc.usleep
  import typealias Glibc.useconds_t
#else
  import func      Darwin.C.usleep
  import typealias Darwin.C.useconds_t
#endif

open class TM1637 : CustomStringConvertible {
  
  public enum Brightness : UInt8, Equatable {
    case darkest      = 0
    case dark         = 1
    case typical      = 2
    case brighter     = 3
    case evenBrighter = 4
    case prettyBright = 5
    case sun          = 6
    case highest      = 7
    
    public func reduced() -> Brightness {
      guard rawValue > 0 else { return self }
      return Brightness(rawValue: rawValue - 1)!
    }
    
    public func increased() -> Brightness {
      guard rawValue < 7 else { return self }
      return Brightness(rawValue: rawValue + 1)!
    }
  }
  
  private let clock : GPIO
  private let data  : GPIO
  
  private var _brightness : Brightness?
  
  // active segment values
  private var segment1 : SevenSegment?
  private var segment2 : SevenSegment?
  private var segment3 : SevenSegment?
  private var segment4 : SevenSegment?
  
  public init(clock: GPIO, data: GPIO) {
    self.clock           = clock
    self.data            = data
    self.clock.direction = .OUT
    self.data.direction  = .OUT
  }
  
  // MARK: - API

  open var brightness : Brightness? {
    set {
      assert(newValue != nil, "cannot set a nil value?!")
      guard let newValue = newValue else { return }
      guard _brightness != newValue else { return }
      
      _brightness = newValue
      flush()
    }
    get { return _brightness }
  }
  
  open func show<T1, T2, T3, T4>(s1: T1? = nil, s2: T2? = nil,
                                 s3: T3? = nil, s4: T4? = nil)
            where T1: SevenSegmentRepresentable,
                  T2: SevenSegmentRepresentable,
                  T3: SevenSegmentRepresentable,
                  T4: SevenSegmentRepresentable
  {
    var didChange = false
    
    func apply<T: SevenSegmentRepresentable>(_ value: T?,
                                             _ storage: inout SevenSegment?)
    {
      guard let v = value?.sevenSegmentValue else { return }
      guard storage != v                     else { return }
      storage = v
      didChange = true
    }
    
    apply(s1, &segment1)
    apply(s2, &segment2)
    apply(s3, &segment3)
    apply(s4, &segment4)
    
    if didChange { flush() }
  }

  open func turnOff() {
    segment1 = .off
    segment2 = .off
    segment3 = .off
    segment4 = .off
    flush()
  }

  private func flush() {
    let ADDR_AUTO  : UInt8 = 0x40
    let STARTADDR  : UInt8 = 0xC0
    let BRIGHTNESS : UInt8 = 0x88
    
    let byte0 = segment1?.rawValue ?? 0
    let byte1 = segment2?.rawValue ?? 0
    let byte2 = segment3?.rawValue ?? 0
    let byte3 = segment4?.rawValue ?? 0
    
    start()
    write(ADDR_AUTO)
    stop()
    
    start()
    write(STARTADDR)
    write(byte0)
    write(byte1)
    write(byte2)
    write(byte3)
    stop()
    
    start()
    write(BRIGHTNESS + (brightness ?? .typical).rawValue)
    stop()
  }
  
  
  // MARK: - Low Level Protocol
  
  private func start() {
    clock.value = 1 // send start signal to TM1637
    data.value  = 1
    data.value  = 0
    clock.value = 0
  }
  private func stop() {
    clock.value = 0
    data.value  = 0
    clock.value = 1
    data.value  = 1
  }
  
  private func write(_ b: UInt8) {
    let flag : UInt8 = 0x01
    
    var todo = b
    for _ in 0..<8 {
      clock.value = 0
      data.value  = (todo & flag) != 0 ? 1 : 0
      todo = todo >> 1
      clock.value = 1
    }
    
    waitForACK()
  }
  
  private func waitForACK() {
    let pollIntervalInMicroSeconds : useconds_t = 1000 // 1ms
    
    clock.value = 0
    data.value  = 1
    clock.value = 1
    
    data.direction = .IN
    defer { data.direction = .OUT }
    
    // funny, polling
    while data.value != 0 {
      usleep(pollIntervalInMicroSeconds)
      
      if data.value != 0 {
        data.direction = .OUT
        defer { data.direction = .IN }
        data.value = 0
      }
    }
  }
  
  
  // MARK: - Description
  
  open var description : String {
    var ms = "<TM1637: clock-pin=\(clock) data-pin=\(data)"
    
    if let brightness = _brightness {
      ms += " brightness=\(brightness)"
    }
    
    if let s = segment1 { ms += " 1[\(s)]" }
    else                { ms += " 1[-]"    }
    
    if let s = segment2 { ms += " 2[\(s)]" }
    else                { ms += " 2[-]"    }
    
    if let s = segment3 { ms += " 3[\(s)]" }
    else                { ms += " 3[-]"    }
    
    if let s = segment4 { ms += " 4[\(s)]" }
    else                { ms += " 4[-]"    }
    
    ms += ">"
    return ms
  }
}

