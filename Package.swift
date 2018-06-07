// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftyTM1637",
    products: [
        .library(
            name: "SwiftyTM1637",
            targets: ["SwiftyTM1637"]),
    ],
    dependencies: [
        .package(url: "https://github.com/uraimo/SwiftyGPIO.git",
                 from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "SwiftyTM1637",
            dependencies: [ "SwiftyGPIO" ]),
        .target(
            name: "Clock",
            dependencies: [ "SwiftyTM1637", "SwiftyGPIO" ]),
        .testTarget(
            name: "SwiftyTM1637Tests",
            dependencies: ["SwiftyTM1637"]),
    ]
)
