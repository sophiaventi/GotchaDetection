//
//  EnableDetectionScreen.swift
//  GotchaScooterDetection
//
//  Created by Muridi, Mamduh on 2/26/20.
//  Copyright © 2020 AESC Capstone Team 25. All rights reserved.
//

import UIKit
import CoreBluetooth

class EnableDetectionScreen: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    private var centralManager: CBCentralManager!
    //var peripheral: CBPeripheral?
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn{
            print("Bluetooth is On")
            centralManager.scanForPeripherals(withServices: nil, options: nil)
        }
        else{
            print("Bluetooth is not active")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centralManager = CBCentralManager(delegate: self, queue: nil, options: nil)
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {

        print("\nName    :\(peripheral.name ?? "(No name)")")
        print("RSSI :\(RSSI)")
        for ad in advertisementData{
            print("AD Data: \(ad)")
        }
    }
    @IBAction func startDetection(_ sender: UIButton) {
        // Start Bluetooth Scanning
        // switch screen
    }
    
}
