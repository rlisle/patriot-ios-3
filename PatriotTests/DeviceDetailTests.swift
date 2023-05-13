//
//  DeviceDetailTests.swift
//  PatriotTests
//
//  Created by Ron Lisle on 5/31/22.
//


import XCTest
import SwiftUI
@testable import Patriot3

@MainActor
class DeviceDetailTests: XCTestCase {
    
    var vc: UIViewController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        let modelView = PatriotModel(testMode: .on)
        vc = DeviceDetailView().environmentObject(modelView).toVC()
    }
    
    func testDeviceDetailView() throws {
        ciAssertSnapshot(matching: vc, as: .image(on: .iPhone13Pro), record: false)
    }
}
