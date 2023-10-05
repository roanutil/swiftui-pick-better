// swift-tools-version:5.8

import PackageDescription

let package = Package(
    name: "swiftui-pick-better",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
        .watchOS(.v7),
        .tvOS(.v14),
    ],
    products: [
        .library(
            name: "PickBetter",
            targets: ["PickBetter"]
        ),
    ],
    targets: [
        .target(name: "PickBetter"),
    ]
)

package.targets.strictConcurrency()

extension Array where Element == Target {
    func strictConcurrency() {
        forEach { target in
            target.swiftSettings = (target.swiftSettings ?? [])
                + [.enableUpcomingFeature("StrictConcurrency")]
        }
    }
}
