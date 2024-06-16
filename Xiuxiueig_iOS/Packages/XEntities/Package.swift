// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "XEntities",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "XEntities",
            targets: ["XEntities"])
    ],
    targets: [
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "XEntities"),
        .testTarget(
            name: "XEntitiesTests",
            dependencies: ["XEntities"])
    ]
)
