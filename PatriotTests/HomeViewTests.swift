//
//  HomeViewTests.swift
//  PatriotTests
//
//  Created by Ron Lisle on 5/31/22.
//

import Foundation
import XCTest
import SwiftUI
@testable import Patriot3
import SnapshotTesting

@MainActor
class HomeViewTests: XCTestCase {
    
    func testCurrentPath() {
        let fileMgr = FileManager()
        let currentPath = fileMgr.currentDirectoryPath
        let expectedPath = "/" //"Volumes/workspace/repository"
        XCTAssertEqual(currentPath, expectedPath)
    }

   func testIsCI() {
        let isCI = ProcessInfo.processInfo.environment["CI"] == "TRUE"
        XCTAssertTrue(isCI)
    }
    
    func testHomeView() throws {
        let ciPath: StaticString = "/Volumes/workspace/repository/ci_scripts/PatriotTests/HomeViewtests.swift"
        let localPath: StaticString = #file
        var isCIEnvironment: Bool {
            let isCI = ProcessInfo.processInfo.environment["CI"] == "TRUE"
            print("isCIEnvironmant = \(isCI)")
            return isCI
        }
        
        let modelView = PatriotModel(testMode: .on)
        let homeView = HomeView().environmentObject(modelView)
        
        
        //TODO: create a helper for this including .toVC() and as: and record: arguments
        var filePath: StaticString
        if isCIEnvironment {
            filePath = ciPath
        } else {
            filePath = localPath
        }
        print("filePath = \(filePath)")
        assertSnapshot(
            matching: homeView.toVC(),
            as: .image(on: .iPhone13Pro),
            record: false,
            file: filePath)
    }
    
    func testHomeViewWithChangedLights() throws {
        let modelView = PatriotModel(testMode: .on)
        modelView.devices[0].percent = 100
        let homeView = HomeView().environmentObject(modelView)
        assertSnapshot(matching: homeView.toVC(), as: .image(on: .iPhone13Pro), record: false)
    }
}
