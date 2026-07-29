// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "PhotoViewer",
  platforms: [
    .iOS("26.0"),
    .macOS(.v12)
  ],
  products: [
    .library(name: "PhotoViewer", targets: ["PhotoViewer"])
  ],
  dependencies: [
    .package(url: "https://github.com/quien697/CachedAsyncImage.git", from: "1.0.0")
  ],
  targets: [
    .target(name: "PhotoViewer", dependencies: ["CachedAsyncImage"])
  ],
  swiftLanguageModes: [.v6]
)
