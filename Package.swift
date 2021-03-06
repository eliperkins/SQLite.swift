// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "SQLite.swift",
    platforms: [.iOS(.v11), .macOS(.v10_14), .tvOS(.v11), .watchOS(.v5)],
    products: [.library(name: "SQLite", targets: ["SQLite"])],
    targets: [
        .target(name: "SQLite", exclude: ["Info.plist"]),
        .testTarget(
            name: "SQLiteTests", 
            dependencies: ["SQLite"], 
            path: "Tests/SQLiteTests", 
            exclude: ["Info.plist", "fixtures/encrypted-3.x.sqlite", "fixtures/encrypted-4.x.sqlite"]
        )
    ],
    swiftLanguageVersions: [.v4, .v5]
)

#if os(Linux)
    package.dependencies = [.package(url: "https://github.com/stephencelis/CSQLite.git", from: "0.0.3")]
    package.targets = [
        .target(name: "SQLite", exclude: ["Extensions/FTS4.swift", "Extensions/FTS5.swift"]),
        .testTarget(name: "SQLiteTests", dependencies: ["SQLite"], path: "Tests/SQLiteTests", exclude: [
            "FTS4Tests.swift",
            "FTS5Tests.swift"
        ])
    ]
#endif
