// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import Foundation

// As we only want certain dependencies to be loaded for testing purposes, and there is no
// way to let Swift package manager know to only load the packages for testing purposes,
// we manually set testing to enabled or not to load the test dependencies and target.
let enableTests = ProcessInfo.processInfo.environment["ENABLE_TESTS"] == "1" ||
                  ProcessInfo.processInfo.environment["ENABLE_TESTS"] == "true" ||
                  ProcessInfo.processInfo.environment["ENABLE_TESTS"] == "yes"

var dependencies: [Package.Dependency] = []
var targets: [Target] = [
    .target(name: "InjectPropertyWrapper", dependencies: []),
]

if enableTests {
    dependencies.append(
        .package(url: "https://github.com/Swinject/Swinject.git", from: "2.6.2")
    )
    
    targets.append(
        .testTarget(
            name: "InjectPropertyWrapperTests",
            dependencies: [
                "InjectPropertyWrapper",
                "Swinject"
            ]
        )
    )
}

let package = Package(
    name: "InjectPropertyWrapper",
    products: [
        .library(name: "InjectPropertyWrapper", targets: ["InjectPropertyWrapper"]),
    ],
    dependencies: dependencies,
    targets: targets
)
