//
//  MenuViewTests.swift
//  PatriotTests
//
//  Created by Ron Lisle on 6/1/22.
//


import XCTest
@testable import Patriot3

@MainActor
class MenuViewTests: XCTestCase {
    
    func testMenuView() throws {
        let modelView = PatriotModel(testMode: .on)
        let menuView = MenuView().environmentObject(modelView)
        ciAssertSnapshot(matching: menuView.toVC(), as: .image(on: .iPhone13Pro), record: false)
    }
}
