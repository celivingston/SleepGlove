//
//  BLEtoAudio.swift
//  SleepGlove
//
//  Created by Catherine Livingston on 4/10/22.
//

import Foundation
import UserNotifications

class BLEtoAudio: NSObject {
    var audioRecorder : AudioRecorder
    var bleManager : BLEManager
    
    init(audioRecorder : AudioRecorder, bleManager : BLEManager) {
        self.audioRecorder = audioRecorder
        self.bleManager = bleManager
        if bleManager.incomingMessage == "sleepMessage" {
            print("Sleep Audio")
            audioRecorder.playRecording(record: audioRecorder.getToSleepRecording())
        }
        if bleManager.incomingMessage == "wakeUp" {
            print("Wake Up Audio")
            let notificationCenter = UNUserNotificationCenter.current()
            let content = UNMutableNotificationContent()
            let acceptAction = UNNotificationAction(identifier: "accept", title: "Accept", options: .foreground)
            let declineAction = UNNotificationAction(identifier: "decline", title: "Decline", options: .destructive)
            let myAlertCategory = UNNotificationCategory(identifier: "WAKEUP_ALERT", actions: [acceptAction, declineAction],
                                                                 intentIdentifiers: [], options:
                                                                UNNotificationCategoryOptions(rawValue: 0))
            notificationCenter.setNotificationCategories([myAlertCategory])
            content.title = "Wake up to record your dreams"
            content.categoryIdentifier = "WAKEUP_ALERT"
            //content.sound = UNNotificationSound.default
            content.sound = UNNotificationSound(named: UNNotificationSoundName("alarm"))
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

            let uuidString = UUID().uuidString
            let request = UNNotificationRequest(identifier: uuidString,
                        content: content, trigger: trigger)
            
            let center = UNUserNotificationCenter.current()
            center.getNotificationSettings { (settings) in
                if settings.authorizationStatus != .authorized {
                    print("Notifications not allowed")
                }
                                //allowed
                else {
                    center.add(request) { (error : Error?) in
                        if let theError = error {
                            print(theError.localizedDescription)
                        }
                    }
                }
            }
            print(center.getPendingNotificationRequests(completionHandler: { notif in
                print(notif.description)
            }))
        }
    }
    
}
