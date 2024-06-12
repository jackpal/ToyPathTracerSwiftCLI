// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ToyPathTracerSwiftCLI",
    platforms: [.macOS(.v15)],
    dependencies: [
      .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.0.2"),
      .package(url: "https://github.com/jackpal/ToyPathTracerSwift.git", from: "1.1.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .executableTarget(
            name: "ToyPathTracerSwiftCLI",
            dependencies: [
              .product(name: "ArgumentParser", package: "swift-argument-parser"),
              "ToyPathTracerSwift"
            ]),
    ],
    swiftLanguageVersions: [.version("6")]
)
