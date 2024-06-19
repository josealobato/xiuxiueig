// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "XLectureCollection",
    defaultLocalization: "en",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "XLectureCollection",
            targets: ["XLectureCollection"])
    ],
    dependencies: [
        .package(name: "XToolKit", path: "../../XToolKit"),
        .package(name: "XEntities", path: "../../XEntities"),
        .package(name: "XCoordinator", path: "../../XCoordinator")
    ],
    targets: [
        .target(
            name: "XLectureCollection",
            dependencies: ["XToolKit", "XEntities", "XCoordinator"]),
        .testTarget(
            name: "XLectureCollectionTests",
            dependencies: ["XLectureCollection", "XToolKit", "XEntities", "XCoordinator"])
    ]
)
