//
//  BLEManager.swift
//  SleepGlove
//
//  Created by Catherine Livingston on 3/1/22.
//

import Foundation
import CoreBluetooth

struct Peripheral: Identifiable {
    let id: Int
    let name: String
    let rssi: Int
}

class BLEManager: NSObject, ObservableObject, CBCentralManagerDelegate {
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
    @Published var peripherals = [Peripheral]()
    var myPeripheal:CBPeripheral?
    @Published var isConnected = false
    
    override init() {
        super.init()

        myCentral = CBCentralManager(delegate: self, queue: nil)
        myCentral.delegate = self
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
            myCentral.connect(peripheral, options: nil)
            print("connected to BLETest")
            myCentral.stopScan()
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        //peripheral.discoverServices([serviceUUID])
        print("Connected to " +  peripheral.name!)
        self.isConnected = true
//        connectButton.isEnabled = false
//        disconnectButton.isEnabled = true
//        sendText1Button.isHidden = false
//        sendText2Button.isHidden = false
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
}
