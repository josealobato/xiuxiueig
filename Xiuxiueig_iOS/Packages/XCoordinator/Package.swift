// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "XCoordinator",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "XCoordinator",
            targets: ["XCoordinator"])
    ],
    dependencies: [
        // No dependencies.
    ],
    targets: [
        .target(
            name: "XCoordinator"),
        .testTarget(
            name: "XCoordinatorTests",
            dependencies: ["XCoordinator"])
    ]
)
