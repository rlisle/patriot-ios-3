//
//  MenuViewTests.swift
//  PatriotTests
//
//  Created by Ron Lisle on 6/1/22.
//


import XCTest
import SwiftUI
@testable import Patriot3

@MainActor
class MenuViewTests: XCTestCase {
    
    var viewController: UIViewController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        let modelView = PatriotModel(testMode: .on)
        let menuView = MenuView().environmentObject(modelView)
        viewController = UIHostingController(rootView: menuView)
    }
    
    func testMenuView() throws {
        ciAssertSnapshot(matching: viewController, as: .image(on: .iPhone13Pro), record: false)
    }
}
