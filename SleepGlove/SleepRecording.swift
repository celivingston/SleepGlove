//
//  SleepRecording.swift
//  SleepGlove
//
//  Created by Catherine Livingston on 3/29/22.
//

import Foundation


class SleepRecording: NSObject, ObservableObject {
    var sleepFocus: String
    var toSleepRecording: Recording?
    var toWakeRecording: Recording?
    var minutesToSleep: Int
    
    override init() {
        self.sleepFocus = ""
        self.minutesToSleep = 0
        self.toSleepRecording = nil
        self.toWakeRecording = nil
    }
    
    func addToSleepRecording(record: Recording?) {
        self.toSleepRecording = record
    }
    
    func addToWakeRecording(record: Recording?) {
        self.toWakeRecording = record
    }
}
