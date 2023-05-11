//
//  HomeViewTests.swift
//  PatriotTests
//
//  Created by Ron Lisle on 5/31/22.
//


import XCTest
import SwiftUI
@testable import Patriot3
//import SnapshotTesting
import XcodeCloudSnapshotTesting

@MainActor
class HomeViewTests: XCTestCase {
    
    func testHomeView() throws {
        let modelView = PatriotModel(testMode: .on)
        let homeView = HomeView().environmentObject(modelView)
        ciAssertSnapshot(matching: homeView.toVC(), as: .image(on: .iPhone13Pro), record: false)
    }
    
    func testHomeViewWithChangedLights() throws {
        let modelView = PatriotModel(testMode: .on)
        modelView.devices[0].percent = 100
        let homeView = HomeView().environmentObject(modelView)
        ciAssertSnapshot(matching: homeView.toVC(), as: .image(on: .iPhone13Pro), record: false)
    }
}
