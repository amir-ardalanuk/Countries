// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Repository",
    platforms: [
        .iOS(SupportedPlatform.IOSVersion.v13)
    ],
    products: [
        .library(
            name: "Repository",
            targets: ["Repository"]),
    ],
    dependencies: [
        .package(name: "Core", path: "../Core"),
        .package(name: "LocalStorage", path: "../LocalStorage")
    ],
    targets: [
        .target(
            name: "Repository",
            dependencies: []),
        .testTarget(
            name: "RepositoryTests",
            dependencies: ["Repository"]),
    ]
)
