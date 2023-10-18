// swift-tools-version:5.8

import PackageDescription

let package = Package(
    name: "swiftui-pick-better",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .watchOS(.v8),
        .tvOS(.v15),
    ],
    products: [
        .library(
            name: "PickBetter",
            targets: ["PickBetter"]
        ),
    ],
    targets: [
        .target(
            name: "PickBetter",
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
