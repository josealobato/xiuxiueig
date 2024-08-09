// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "XGoalPicker",
    defaultLocalization: "en",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "XGoalPicker",
            targets: ["XGoalPicker"])
    ],
    dependencies: [
        .package(name: "XToolKit", path: "../../XToolKit"),
        .package(name: "XEntities", path: "../../XEntities"),
        .package(name: "XCoordinator", path: "../../XCoordinator")
    ],
    targets: [
        .target(
            name: "XGoalPicker",
            dependencies: ["XToolKit", "XEntities", "XCoordinator"]),
        .testTarget(
            name: "XGoalPickerTests",
            dependencies: ["XGoalPicker", "XToolKit", "XEntities", "XCoordinator"])
    ]
)
