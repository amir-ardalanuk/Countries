// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RemoteRepository",
    platforms: [
        .iOS(SupportedPlatform.IOSVersion.v13)
    ],
    products: [
        .library(
            name: "RemoteRepository",
            targets: ["RemoteRepository"]),
    ],
    dependencies: [
        .package(name: "Core", path: "../Core"),
        .package(name: "HTTPClient", path: "../HTTPClient")
    ],
    targets: [
        .target(
            name: "RemoteRepository",
            dependencies: []),
        .testTarget(
            name: "RemoteRepositoryTests",
            dependencies: ["RemoteRepository"]),
    ]
)
