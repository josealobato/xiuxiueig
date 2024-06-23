// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "XOnboarding",
    defaultLocalization: "en",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "XOnboarding",
            targets: ["XOnboarding"])
    ],
    dependencies: [
        .package(name: "XToolKit", path: "../../XToolKit"),
        .package(name: "XEntities", path: "../../XEntities"),
        .package(name: "XCoordinator", path: "../../XCoordinator")
    ],
    targets: [
        .target(
            name: "XOnboarding",
            dependencies: ["XToolKit", "XEntities", "XCoordinator"]),
        .testTarget(
            name: "XOnboardingTests",
            dependencies: ["XOnboarding", "XToolKit", "XEntities", "XCoordinator"])
    ]
)
