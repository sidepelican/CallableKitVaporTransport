// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "CallableKitVaporTransport",
    platforms: [.macOS(.v14)],
    products: [
        .library(name: "CallableKitVaporTransport", targets: ["CallableKitVaporTransport"]),
    ],
    dependencies: [
        .package(url: "https://github.com/sidepelican/CallableKit.git", from: "2.0.0-alpha.1"),
        .package(url: "https://github.com/vapor/vapor.git", from: "4.106.7"),
    ],
    targets: [
        .target(
            name: "CallableKitVaporTransport",
            dependencies: [
                .product(name: "CallableKit", package: "CallableKit"),
                .product(name: "Vapor", package: "vapor"),
            ]
        ),
        .testTarget(
            name: "CallableKitVaporTransportTests",
            dependencies: [
                .product(name: "CallableKit", package: "CallableKit"),
                .product(name: "Vapor", package: "vapor"),
                .product(name: "XCTVapor", package: "vapor"),
                "CallableKitVaporTransport",
            ]
        ),
    ]
)
