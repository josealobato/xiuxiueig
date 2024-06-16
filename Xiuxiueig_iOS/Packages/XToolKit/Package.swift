// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "XToolKit",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "XToolKit",
            targets: ["XToolKit"])
    ],
    targets: [
        .target(
            name: "XToolKit"),
        .testTarget(
            name: "XToolKitTests",
            dependencies: ["XToolKit"])
    ]
)
