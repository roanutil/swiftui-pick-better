// swift-tools-version: 5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Shared",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
        .watchOS(.v7),
        .tvOS(.v14),
    ],
    products: [
        .library(
            name: "Shared",
            targets: ["Shared"]
        ),
    ],
    dependencies: [
        .package(name: "swiftui-pick-better", path: "../../"),
    ],
    targets: [
        .target(
            name: "Shared",
            dependencies: [
                .product(name: "PickBetter", package: "swiftui-pick-better"),
            ]
        ),
    ]
)
