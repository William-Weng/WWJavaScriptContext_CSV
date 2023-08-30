// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WWJavaScriptContext+CSV",
    platforms: [
        .iOS(.v14),
    ],
    products: [
        .library(name: "WWJavaScriptContext+CSV", targets: ["WWJavaScriptContext+CSV"]),
    ],
    dependencies: [
        .package(url: "https://github.com/William-Weng/WWJavaScriptContext", from: "1.0.1"),
    ],
    targets: [
        .target(name: "WWJavaScriptContext+CSV", dependencies: ["WWJavaScriptContext"], resources: [.process("Script")]),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
