// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "MediaFileSystem",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "MediaFileSystem",
            targets: ["MediaFileSystem"])
    ],
    dependencies: [
        .package(name: "XToolKit", path: "../../XToolKit")
    ],
    targets: [
        .target(
            name: "MediaFileSystem",
            dependencies: ["XToolKit"],
            resources: [
                .copy("Resources/1-Introduction to Ratpenat 1.mp3"),
                .copy("Resources/2-Introduction to Ratpenat 2.mp3"),
                .copy("Resources/3-Introduction to Ratpenat 3.mp3")
            ]
        ),
        .testTarget(
            name: "MediaFileSystemTests",
            dependencies: ["MediaFileSystem", "XToolKit"])
    ]
)
