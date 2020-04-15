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
            if(enabled){
                centralManager.scanForPeripherals(withServices: [CBUUID(string: "0000180F-0000-1000-8000-00805F9B34FB")], options: nil)
            }
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
        let doubleRSSI = RSSI as! Double
        let exponent = (-69.0-doubleRSSI)/20.0
        let distance = pow(10, exponent)
        if(distance<2.0){
            sendNotification()
        }
        print("\nName    :\(peripheral.name ?? "(No name)")")
        print("RSSI :\(RSSI)")
        print("Distance: \(distance)")
        
    }
    @IBAction func toggleDetection(_ sender: UIButton) {
        sendNotification()
        enabled = !enabled
        if enabled {
            centralManager.scanForPeripherals(withServices: nil, options: nil)
        }
        
    }
    
    func sendNotification(){
        //Is currently not called yet
        let content = UNMutableNotificationContent()
        content.title = "Scooter Detected!"
        content.body = "Please be caution, you are approaching a scooter"
        content.badge = 1
        content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "beep.mp3"))
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
    
        let request = UNNotificationRequest(identifier: "scooterDetected", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    
}
