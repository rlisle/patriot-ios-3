//
//  Photon.swift
//  Patriot
//
//  This class provides the interface to a Photon microcontroller.
//
//  The Photon will be interrogated to identify the model
//  that it implements using the published variables:
//
//      deviceNames     is a list of all the devices, types, and values exposed on the Photon
//                      format is T:Name=#
//
//  This file uses the Particle SDK:
//      https://docs.particle.io/reference/ios/#common-tasks
//
//  Created by Ron Lisle on 4/17/17
//  Copyright © 2016, 2017 Ron Lisle. All rights reserved.
//

import Foundation
import Particle_SDK


class Photon
{
    // Cached list of device names exposed by Photon, used only for diagnostic purposes
    // after being returned to completion
    private var deviceInfos: [DeviceInfo] = []
    
    internal let particleDevice: ParticleDevice! // Reference to Particle-SDK device object
    
    public var name: String
    {
        get {
            return particleDevice.name ?? "unknown"
        }
    }
    
    
    required init(device: ParticleDevice)
    {
        particleDevice  = device
    }

    public func readDevices(completion: @escaping ([DeviceInfo]) -> Void)
    {
        deviceInfos = []
        readVariable("Devices") { (result) in
            if let result = result {
                self.parseDeviceNames(result)
                completion(self.deviceInfos)
                return
            }
        }
        completion([])
    }
    
    private func parseDeviceNames(_ deviceString: String)
    {
        print("parseDeviceNames: \(deviceString)")
        let items = deviceString.components(separatedBy: ",")
        for item in items
        {
            // Format is now type:name=value ("C|L|P|S:<name>@<room>=<0-255>") @room is optional
            // Refactoring:
            let parts = item.components(separatedBy: CharacterSet(charactersIn: ":@="))     // type:name@room=value
            if parts.count >= 3 {
                let deviceInfo = DeviceInfo(
                    photonName: self.name,
                    name: parts[1],
                    type: DeviceType(rawValue: parts[0]) ?? DeviceType.Unknown,
                    percent: Int(parts[ parts.count == 4 ? 3 : 2]) ?? 0,
                    room: parts.count == 4 ? parts[2] : "Default"
                )
                print("Adding deviceInfo \(parts[1])")
                deviceInfos.append(deviceInfo)

            } else {
                print("Invalid device info: \(item)")
            }
        }
    }
    
    private func readVariable(_ name: String, completion: @escaping (String?) -> Void)
    {
        guard particleDevice.variables[name] != nil else
        {
            print("Variable \(name) doesn't exist on photon \(self.name)")
            completion(nil)
            return
        }
        particleDevice.getVariable(name) { (result: Any?, error: Error?) in
            completion(result as? String)
        }
    }
}
