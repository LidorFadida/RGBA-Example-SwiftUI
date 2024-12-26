// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SmartLight",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "SmartLight",
            targets: ["SmartLight"]),
    ],
    dependencies: [
        .package(path: ".../Slider")
    ],
    targets: [
        .target(
            name: "SmartLight",
            dependencies: [
                .product(name: "Slider", package: "Slider")
            ],
            resources: [
                .process("Resources")
            ]
        ),
    ]
)
