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
        .package(name: "XToolKit", path: "../../XToolKit")
    ],
    targets: [
        .target(
            name: "XCoordinator",
            dependencies: ["XToolKit"]),
        .testTarget(
            name: "XCoordinatorTests",
            dependencies: ["XCoordinator", "XToolKit"])
    ]
)
