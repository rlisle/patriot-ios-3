//
//  MQTTTests.swift
//  PatriotTests
//
//  Created by Ron Lisle on 5/21/22.
//

import XCTest
@testable import Patriot3

class MQTTTests: XCTestCase {

    var mqtt: MQTTManager!
    var mqttHandler: MQTTHandler!
    
    override func setUpWithError() throws {
        mqttHandler = MQTTHandler()
        mqtt = MQTTManager(testMode: .on)
        mqtt.mqttDelegate = mqttHandler
    }

    func testInstantiation() throws {
        XCTAssertNotNil(mqtt)
    }
}

class MQTTHandler: MQTTReceiving {
    
    var receivedTopic: String = ""
    var receivedMessage: String = ""
    
    func connectionDidChange(isConnected: Bool) {
        
    }
    
    func didReceiveMessage(topic: String, message: String) {
        receivedMessage = message
        receivedTopic = topic
    }

}
