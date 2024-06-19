// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FeedbackSupply",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "FeedbackSupplyAppleFramework",
            targets: ["FeedbackSupplyApplePackageWrapperTarget"]),
    ],
    dependencies: [
        .package(url: "https://github.com/marmelroy/Zip.git", from: "2.1.2")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "FeedbackSupplyApplePackageWrapperTarget",
            dependencies: [
                .target(name: "FeedbackSupplyAppleFrameworkBinaryTarget"),
                .product(name: "Zip", package: "zip")
            ],
            path: "./Sources/FeedbackSupplyApplePackageWrapperTarget"
        ),
        .binaryTarget(
            name: "FeedbackSupplyAppleFrameworkBinaryTarget",
            path: "./Sources/FeedbackSupplyAppleFramework.xcframework"
        )
    ]
)
