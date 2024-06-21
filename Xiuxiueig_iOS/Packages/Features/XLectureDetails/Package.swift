// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "XLectureDetails",
    defaultLocalization: "en",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "XLectureDetails",
            targets: ["XLectureDetails"])
    ],
    dependencies: [
        .package(name: "XToolKit", path: "../../XToolKit"),
        .package(name: "XEntities", path: "../../XEntities"),
        .package(name: "XCoordinator", path: "../../XCoordinator")
    ],
    targets: [
        .target(
            name: "XLectureDetails",
            dependencies: ["XToolKit", "XEntities", "XCoordinator"]),
        .testTarget(
            name: "XLectureDetailsTests",
            dependencies: ["XLectureDetails", "XToolKit", "XEntities", "XCoordinator"])
    ]
)
