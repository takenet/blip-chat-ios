// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "BlipChat",
    platforms: [
        .iOS(.v18)
    ],
    products: [
        .library(
            name: "BlipChat",
            targets: ["BlipChat"]
        )
    ],
    targets: [
        .target(
            name: "BlipChat",
            path: "src/BlipChat",
            exclude: [
                "Info.plist",
                "BlipChat.h"
            ],
            resources: [
                .process("Storyboard.storyboard"),
                .process("Assets.xcassets"),
                .process("BlipSdkTemplate.html")
            ],
            swiftSettings: [
                .swiftLanguageMode(.v5)
            ]
        )
    ]
)
