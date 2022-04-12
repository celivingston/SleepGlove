//
//  AppDelegate.swift
//  SleepGlove
//
//  Created by Catherine Livingston on 4/11/22.
//

import Foundation
import UIKit
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("Your code here")
        return true
    }
    
    func applicationDidFinishLaunching(_ application: UIApplication, didFinishLauncingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureUserNotifications()
        return true
    }
    
}

// MARK: - UNUserNotificationCenterDelegate
extension AppDelegate: UNUserNotificationCenterDelegate {
  func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    willPresent notification: UNNotification,
    withCompletionHandler completionHandler: (UNNotificationPresentationOptions) -> Void
  ) {
      completionHandler([.alert, .banner, .sound])
  }
    
    private func configureUserNotifications() {
        UNUserNotificationCenter.current().delegate = self
    }

}
