//
//  NotificationsManager.swift
//  SleepGlove
//
//  Created by Catherine Livingston on 4/11/22.
//

import Foundation
import UserNotifications
import SwiftUI
class NotificationsManager : NSObject {
    @State var settings : UNNotificationSettings?
    
    func requestAuthorization(completion: @escaping  (Bool) -> Void) {
      UNUserNotificationCenter.current()
        .requestAuthorization(options: [.alert, .sound, .badge]) { granted, _  in
            self.fetchNotificationSettings()
            completion(granted)
        }
    }
    
    func fetchNotificationSettings() {
      // 1
      UNUserNotificationCenter.current().getNotificationSettings { settings in
        // 2
        DispatchQueue.main.async {
          self.settings = settings
        }
      }
    }


}
