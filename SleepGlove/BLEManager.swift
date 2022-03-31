//
//  BLEManager.swift
//  SleepGlove
//
//  Created by Catherine Livingston on 3/1/22.
//

import Foundation
import CoreBluetooth
import UIKit
let BLE_CBUUID = CBUUID(string: "ab0828b1-198e-4351-b779-901fa0e0371e")

struct Peripheral: Identifiable {
    let id: Int
    let name: String
    let rssi: Int
}

class BLEManager: NSObject, ObservableObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            isSwitchedOn = true
        }
        else {
            isSwitchedOn = false
        }
    }
    
    var myCentral: CBCentralManager!
    @Published var isScanning = false
    @Published var isSwitchedOn = false
    var peripherals = [Peripheral]()
    var myPeripheal:CBPeripheral?
    var myCharacteristic:CBCharacteristic?
    @Published var isConnected = false
    
    override init() {
        super.init()
        let centralQueue: DispatchQueue = DispatchQueue(label: "com.iosbrain.centralQueueName", attributes: .concurrent)
                // STEP 2: create a central to scan for, connect to,
                // manage, and collect data from peripherals
        myCentral = CBCentralManager(delegate: self, queue: centralQueue)
//        myCentral = CBCentralManager(delegate: self, queue: nil)
//        myCentral.delegate = self
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        var peripheralName: String!
           
        if let name = advertisementData[CBAdvertisementDataLocalNameKey] as? String {
            peripheralName = name
        }
        else {
            peripheralName = "Unknown"
        }
           
        let newPeripheral = Peripheral(id: peripherals.count, name: peripheralName, rssi: RSSI.intValue)
        print(newPeripheral)
        peripherals.append(newPeripheral)
        
        if newPeripheral.name == "BLETest" {
            myPeripheal = peripheral
            myPeripheal?.delegate = self
            myCentral.connect(peripheral, options: nil)
            print("connected to BLETest")
            myCentral.stopScan()
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else { return }
        myCharacteristic = characteristics[0]

    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {

        for service in peripheral.services! {

            if service.uuid == BLE_CBUUID {

                print("Service: \(service)")

                    // STEP 9: look for characteristics of interest
                    // within services of interest
                peripheral.discoverCharacteristics(nil, for: service)
                print(myPeripheal?.state ?? "no value")
            }

        }

    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.discoverServices([BLE_CBUUID])
        print("Connected to " +  peripheral.name!)
        DispatchQueue.main.async {
            self.isConnected = true
        }
        
    }
    
    func startScanning() {
        print("startScanning")
        self.isScanning = true
        myCentral.scanForPeripherals(withServices: nil, options: nil)
    }
    
    func stopScanning() {
        print("stopScanning")
        self.isScanning = false
        myCentral.stopScan()
    }
    
    func sendText(text: String) {
        print("Sending text...")
        print(myPeripheal?.name ?? "no name of peripheal")
        print(myCharacteristic ?? "no characteristic")
        if (myPeripheal != nil && myCharacteristic != nil) {
            let data = text.data(using: .utf8)
            myPeripheal!.writeValue(data!,  for: myCharacteristic!, type: CBCharacteristicWriteType.withResponse)
        }
    }
}
