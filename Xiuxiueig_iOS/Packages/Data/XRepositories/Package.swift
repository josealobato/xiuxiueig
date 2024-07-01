// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "XRepositories",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "XRepositories",
            targets: ["XRepositories"])
    ],
    dependencies: [
        .package(name: "XToolKit", path: "../../XToolKit")
    ],
    targets: [
        .target(
            name: "XRepositories",
            dependencies: ["XToolKit"]),
        .testTarget(
            name: "XRepositoriesTests",
            dependencies: ["XRepositories", "XToolKit"])
    ]
)
