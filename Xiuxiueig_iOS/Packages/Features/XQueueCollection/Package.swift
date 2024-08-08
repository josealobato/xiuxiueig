// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "XQueueCollection",
    defaultLocalization: "en",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "XQueueCollection",
            targets: ["XQueueCollection"])
    ],
    dependencies: [
        .package(name: "XToolKit", path: "../../XToolKit"),
        .package(name: "XEntities", path: "../../XEntities"),
        .package(name: "XCoordinator", path: "../../XCoordinator")
    ],
    targets: [
        .target(
            name: "XQueueCollection",
            dependencies: ["XToolKit", "XEntities", "XCoordinator"]),
        .testTarget(
            name: "XQueueCollectionTests",
            dependencies: ["XQueueCollection", "XToolKit", "XEntities", "XCoordinator"])
    ]
)
