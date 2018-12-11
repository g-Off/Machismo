// swift-tools-version:4.2
import PackageDescription

let package = Package(
    name: "Machismo",
    products: [
        .library(name: "Machismo", targets: ["Machismo"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(name: "Machismo", dependencies: []),
        .testTarget(name: "MachismoTests", dependencies: ["Machismo"]),
    ]
)
