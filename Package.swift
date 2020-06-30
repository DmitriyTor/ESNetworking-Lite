// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ESNetworking-Lite",
    platforms: [.iOS(.v10), .macOS(.v10_13)],
    products: [
        .library(
            name: "ESNetworking-Lite",
            targets: ["ESNetworking-Lite"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "ESNetworking-Lite",
            dependencies: [],
            exclude: ["docs"]),
        .testTarget(
            name: "ESNetworking-LiteTests",
            dependencies: ["ESNetworking-Lite"],
            exclude: ["docs"]),
    ]
)
