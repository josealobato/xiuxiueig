// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "XPlayer",
    defaultLocalization: "en",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "XPlayer",
            targets: ["XPlayer"])
    ],
    dependencies: [
        .package(name: "XToolKit", path: "../../XToolKit"),
        .package(name: "XEntities", path: "../../XEntities"),
        .package(name: "XCoordinator", path: "../../XCoordinator")
    ],
    targets: [
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "XPlayer",
            dependencies: ["XToolKit", "XEntities", "XCoordinator"]),
        .testTarget(
            name: "XPlayerTests",
            dependencies: ["XPlayer", "XToolKit", "XEntities", "XCoordinator"])
    ]
)
