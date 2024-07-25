// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "MediaConsistencyService",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "MediaConsistencyService",
            targets: ["MediaConsistencyService"])
    ],
    dependencies: [
        .package(name: "XToolKit", path: "../../XToolKit"),
        .package(name: "XRepositories", path: "../../Data/XRepositories"),
        .package(name: "MediaFileSystem", path: "../../Data/MediaFileSystem"),
        .package(name: "XCoordinator", path: "../../XCoordinator")
    ],
    targets: [
        .target(
            name: "MediaConsistencyService",
            dependencies: ["XToolKit", "XRepositories", "MediaFileSystem", "XCoordinator"]
        ),
        .testTarget(
            name: "MediaConsistencyServiceTests",
            dependencies: ["MediaConsistencyService", "XToolKit", "XRepositories", "MediaFileSystem", "XCoordinator"]
        )
    ]
)
