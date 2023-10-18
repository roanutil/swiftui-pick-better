// swift-tools-version: 5.5

import PackageDescription

let package = Package(
    name: "Shared",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .watchOS(.v8),
        .tvOS(.v15),
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
            ],
            swiftSettings: [
                .enableUpcomingFeature("BareSlashRegexLiterals"),
                .enableUpcomingFeature("ConciseMagicFile"),
                .enableUpcomingFeature("ExistentialAny"),
                .enableUpcomingFeature("ForwardTrailingClosures"),
                .enableUpcomingFeature("ImplicitOpenExistentials"),
                .enableUpcomingFeature("StrictConcurrency"),
            ]
        ),
    ]
)
