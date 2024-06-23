// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "XLogin",
    defaultLocalization: "en",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "XLogin",
            targets: ["XLogin"])
    ],
    dependencies: [
        .package(name: "XToolKit", path: "../../XToolKit"),
        .package(name: "XEntities", path: "../../XEntities"),
        .package(name: "XCoordinator", path: "../../XCoordinator")
    ],
    targets: [
        .target(
            name: "XLogin",
            dependencies: ["XToolKit", "XEntities", "XCoordinator"]),
        .testTarget(
            name: "XLoginTests",
            dependencies: ["XLogin", "XToolKit", "XEntities", "XCoordinator"])
    ]
)
