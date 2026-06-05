// swift-tools-version:5.0
//
//  Package.swift
//

import PackageDescription

let package = Package(name: "DPCoordinator",
                      platforms: [.iOS(.v18)],
                      products: [.library(name: "DPCoordinator",
                                          targets: ["DPCoordinator"])],
                      targets: [.target(name: "DPCoordinator",
                                        path: "DPCoordinator/DPCoordinator/Source",
                                        publicHeadersPath: "")],
                      swiftLanguageVersions: [.v5])
