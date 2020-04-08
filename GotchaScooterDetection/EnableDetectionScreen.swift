//
//  EnableDetectionScreen.swift
//  GotchaScooterDetection
//
//  Created by Muridi, Mamduh on 2/26/20.
//  Copyright © 2020 AESC Capstone Team 25. All rights reserved.
//

import UIKit
import CoreBluetooth
import UserNotifications

class EnableDetectionScreen: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    private var centralManager: CBCentralManager!
    private var enabled:Bool = false
    
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
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in
        })
        centralManager = CBCentralManager(delegate: self, queue: nil, options: nil)
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        print("\nName    :\(peripheral.name ?? "(No name)")")
        print("RSSI :\(RSSI)")
        for ad in advertisementData{
            print("AD Data: \(ad)")
        }
        
        
    }
    @IBAction func toggleDetection(_ sender: UIButton) {
        enabled = !enabled
        //Will move to appropiate place later
        let content = UNMutableNotificationContent()
        content.title = "Scooter Detected!"
        content.subtitle = "You are approaching a scooter"
        content.body = "Please be caution, you are approaching a scooter"
        content.badge = 1
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: "scooterDetected", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    
}
