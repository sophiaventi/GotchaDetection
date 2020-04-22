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
        // Here is where bluetooth access is requested
        if central.state == .poweredOn{
            print("Bluetooth is On")
            if(enabled){
                // Bluetooth scanning is done using this function
                centralManager.scanForPeripherals(withServices: nil, options: nil)
            }
        }
        else{
            print("Bluetooth is not active")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // requesting access to send notifications
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in
        })
        centralManager = CBCentralManager(delegate: self, queue: nil, options: nil)
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        // This function scans for bluetooth signals and assess their distance.
        //RSSI gives us signal strength, converting it to a double allows us to us it in our distance calculations
        let doubleRSSI = RSSI as! Double
        let exponent = (-69.0-doubleRSSI)/20.0 //-69 and 20 are constants
        let distance = pow(10, exponent) //distance is given in meters
        if(distance<2.0){
            sendNotification()
        }
        
    }
    @IBAction func toggleDetection(_ sender: UIButton) {
        enabled = !enabled // this controls ble scanning
        if enabled {
            centralManager.scanForPeripherals(withServices: nil, options: nil)
        }
        
    }
    
    func sendNotification(){
        let content = UNMutableNotificationContent()
        // Building notification
        content.title = "Scooter Detected!"
        content.body = "Please be cautious, you are approaching a scooter"
        
        //Using a sound different from the defualt lets users know a the notification is from our app
        content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "beep.mp3"))
        
        // Building the notification request
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: "scooterDetected", content: content, trigger: trigger)
        
        // Sending the notification
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    
}
