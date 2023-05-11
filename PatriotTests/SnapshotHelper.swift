//
//  AssertSnapshot.swift
//
//
//  Created by Morten Bek Ditlevsen on 23/12/2021.
//

import SwiftUI
import SnapshotTesting
import XCTest

extension SwiftUI.View {
    public func toVC() -> UIViewController {
        let vc = UIHostingController(rootView: self)
        vc.view.frame = UIScreen.main.bounds
        return vc
    }
}

//public func assertSnapshot<Value, Format>(
//    matching value: @autoclosure () throws -> Value,
//    as snapshotting: Snapshotting<Value, Format>,
//    named name: String? = nil,
//    record recording: Bool = false,
//    timeout: TimeInterval = 5,
//    file: StaticString = #file,
//    testName: String = #function,
//    line: UInt = #line
//) {
//    let isCI = ProcessInfo.processInfo.environment["CI"] == "TRUE"
//    let sourceRoot = URL(fileURLWithPath: ProcessInfo.processInfo.environment["SOURCE_ROOT"]!,
//                         isDirectory: true)
//
//    let fileUrl = URL(fileURLWithPath: "\(file)", isDirectory: false)
//    let fileName = fileUrl.deletingPathExtension().lastPathComponent
//
//    let absoluteSourceTestPath = fileUrl
//        .deletingLastPathComponent()
//        .appendingPathComponent("__Snapshots__")
//        .appendingPathComponent(fileName)
//    var components = absoluteSourceTestPath.pathComponents
//    let sourceRootComponents = sourceRoot.pathComponents
//    for component in sourceRootComponents {
//        if components.first == component {
//            components = Array(components.dropFirst())
//        } else {
//            XCTFail("Test file does not share a prefix path with SOURCE_ROOT")
//            return
//        }
//    }
//    var snapshotDirectoryUrl = sourceRoot
//    if isCI {
//        snapshotDirectoryUrl = snapshotDirectoryUrl.appendingPathComponent("ci_scripts")
//    }
//    snapshotDirectoryUrl = snapshotDirectoryUrl.appendingPathComponent("Artifacts")
//    for component in components {
//        snapshotDirectoryUrl = snapshotDirectoryUrl.appendingPathComponent(component)
//    }
//
//    let failure = verifySnapshot(
//        matching: try value(),
//        as: snapshotting,
//        named: name,
//        record: recording,
//        snapshotDirectory: snapshotDirectoryUrl.path,
//        timeout: timeout,
//        file: file,
//        testName: testName
//    )
//    guard let message = failure else { return }
//    XCTFail("\(message) snap: \(snapshotDirectoryUrl)", file: file, line: line)
//}

// This is the code from XcodeCloudSnapshotTesting
//import Foundation
//@_exported import SnapshotTesting
//import XCTest

/// Returns a valid snapshot directory under the project’s `ci_scripts`.
///
/// - Parameter file: A `StaticString` representing the current test’s filename.
/// - Returns: A directory for the snapshots.
/// - Note: It makes strong assumptions about the structure of the project; namely,
///   it expects the project to consist of a single package located at the root.
func snapshotDirectory(
    for file: StaticString,
    testsPathComponent: String = "Tests",
    packagesPathComponent: String = "Packages",
    ciScriptsPathComponent: String = "ci_scripts",
    snapshotsPathComponent: String = "__Snapshots__"
) -> String {
    let fileURL = URL(fileURLWithPath: "\(file)", isDirectory: false)

    let packageRootPath = fileURL
        .pathComponents
        .prefix(while: { $0 != testsPathComponent && $0 != packagesPathComponent })
    print("snapshotDirectory: testsPathComponent = \(testsPathComponent)")

    let testsPath = packageRootPath + [testsPathComponent]
    print("snapshotDirectory: testsPath = \(testsPath)")

    let relativePath = fileURL
        .deletingPathExtension()
        .pathComponents
        .dropFirst(testsPath.count)
    print("snapshotDirectory: relativePath = \(relativePath)")

    print("snapshotDirectory: packageRootPath = \(packageRootPath)")
    print("snapshotDirectory: ciScriptsPathComponent = \(ciScriptsPathComponent)")
    print("snapshotDirectory: snapshotsPathComponent = \(snapshotsPathComponent)")
    let snapshotDirectoryPath = packageRootPath + [ciScriptsPathComponent, snapshotsPathComponent] +
        relativePath
    return snapshotDirectoryPath.joined(separator: "/")
}

/// Asserts that a given value matches references on disk.
///
/// - Parameters:
///   - value: A value to compare against a reference.
///   - snapshotting: An array of strategies for serializing, deserializing, and comparing values.
///   - recording: Whether or not to record a new reference.
///   - timeout: The amount of time a snapshot must be generated in.
///   - file: The file in which failure occurred. Defaults to the file name of the test case in
/// which this function was called.
///   - testName: The name of the test in which failure occurred. Defaults to the function name of
/// the test case in which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this
/// function was called.
///   - testsPathComponent: The name of the tests directory. Defaults to “Tests”.
@MainActor
public func ciAssertSnapshot<Value>(
    matching value: @autoclosure () throws -> Value,
    as snapshotting: Snapshotting<Value, some Any>,
    named name: String? = nil,
    record recording: Bool = false,
    timeout: TimeInterval = 5,
    file: StaticString = #file,
    testName: String = #function,
    line: UInt = #line,
    testsPathComponent: String = "Tests"
) {
    let dir = snapshotDirectory(for: file, testsPathComponent: testsPathComponent)
    print("ciAssertSnapshot dir = \(dir)")
    let failure = verifySnapshot(
        matching: try value(),
        as: snapshotting,
        named: name,
        record: recording,
        snapshotDirectory: snapshotDirectory(for: file, testsPathComponent: testsPathComponent),
        timeout: timeout,
        file: file,
        testName: testName
    )

    guard let message = failure else { return }
    XCTFail(message, file: file, line: line)
}
