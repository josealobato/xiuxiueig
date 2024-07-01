// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "XPreferences",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "XPreferences",
            targets: ["XPreferences"])
    ],
    dependencies: [
        .package(name: "XToolKit", path: "../../XToolKit")
    ],
    targets: [
        .target(
            name: "XPreferences",
            dependencies: ["XToolKit"]),
        .testTarget(
            name: "XPreferencesTests",
            dependencies: ["XPreferences", "XToolKit"])
    ]
)
