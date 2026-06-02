// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "PhotoViewer",
  platforms: [
    .iOS("26.0")
  ],
  products: [
    .library(name: "PhotoViewer", targets: ["PhotoViewer"])
  ],
  targets: [
    .target(name: "PhotoViewer")
  ],
  swiftLanguageModes: [.v6]
)
