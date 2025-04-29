// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "MonacaCapacitorNfcReader",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "MonacaCapacitorNfcReader",
            targets: ["NFCReaderPlugin"])
    ],
    dependencies: [
        .package(url: "https://github.com/ionic-team/capacitor-swift-pm.git", branch: "main")
    ],
    targets: [
        .target(
            name: "NFCReaderPlugin",
            dependencies: [
                .product(name: "Capacitor", package: "capacitor-swift-pm"),
                .product(name: "Cordova", package: "capacitor-swift-pm")
            ],
            path: "ios/Sources/NFCReaderPlugin"),
        .testTarget(
            name: "NFCReaderPluginTests",
            dependencies: ["NFCReaderPlugin"],
            path: "ios/Tests/NFCReaderPluginTests")
    ]
)
