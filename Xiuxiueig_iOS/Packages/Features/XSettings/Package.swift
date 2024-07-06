// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "XSettings",
    defaultLocalization: "en",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "XSettings",
            targets: ["XSettings"])
    ],
    dependencies: [
        .package(name: "XToolKit", path: "../../XToolKit"),
        .package(name: "XEntities", path: "../../XEntities"),
        .package(name: "XCoordinator", path: "../../XCoordinator")
    ],
    targets: [
        .target(
            name: "XSettings",
            dependencies: ["XToolKit", "XEntities", "XCoordinator"]),
        .testTarget(
            name: "XSettingsTests",
            dependencies: ["XSettings", "XToolKit", "XEntities", "XCoordinator"])
    ]
)
