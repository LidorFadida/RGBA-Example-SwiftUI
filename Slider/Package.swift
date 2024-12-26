// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Slider",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "Slider",
            targets: ["Slider"]),
    ],
    dependencies: [
        .package(path: "../Shapes")
    ],
    targets: [
        .target(
            name: "Slider",
            dependencies: [
                .product(name: "Shapes", package: "Shapes")
            ]
        ),
    ]
)
