//
//  DeviceDetailTests.swift
//  PatriotTests
//
//  Created by Ron Lisle on 5/31/22.
//


import XCTest
@testable import Patriot3

@MainActor
class DeviceDetailTests: XCTestCase {
        
    func testDeviceDetailView() throws {
        let modelView = PatriotModel(testMode: .on)
        let vc = DeviceDetailView().environmentObject(modelView)
        ciAssertSnapshot(matching: vc.toVC(), as: .image(on: .iPhone13Pro), record: false)
    }
}
