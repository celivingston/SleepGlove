//
//  CalibrationStart.swift
//  SleepGlove
//
//  Created by Catherine Livingston on 3/2/22.
//

import SwiftUI

struct CalibrationStart: View {
    @ObservedObject var bleManager: BLEManager
    @ObservedObject var audioRecorder: AudioRecorder
    @ObservedObject var sleepRecording: SleepRecording
    @State private var willMoveToNextScreen = false
    
    var body: some View {
        VStack {
            Text("Ready for Sleep")
                .font(.system(size: 30, weight: .bold))
                .padding([.top], 30)
            Text("Before clicking the button, look to your wrist's heartrate sensor at the blinking light. This light should flash as your heart beats. **If the light flashes approximately once per second, you are ready for sleep.** Signs of incorrect placement or a loose band include flickering light, dim light, or rapid/slow blinking. If you believe it's not reading properly, tighten the band or move the sensor around on your wrist until the light looks correct.")
                .padding()
                .font(.system(size: 20, weight: .regular))
                .frame(maxWidth: .infinity, alignment: .leading)
            Button(action: {
                let center = UNUserNotificationCenter.current()
                center.getNotificationSettings { settings in
                    if !(settings.authorizationStatus == .authorized) {
                        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
                            
                            if let error = error {
                                print(error)
                            }
                            if settings.alertSetting != .enabled {
                                print("alerts are not enabled")
                            }
                            if settings.soundSetting != .enabled {
                                print("sounds are not enabled")
                            }
                            // Enable or disable features based on the authorization.
                        }
                    }
                }
                bleManager.sendText(text: "startSleep")
                self.willMoveToNextScreen = true
            }) {
                Text("Go To Sleep")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width: 200)
                    .cornerRadius(30)
                    .padding()
            }   .padding()
                .shadow(radius: 5.0)
                .buttonStyle(MyButtonStyle())
        }.navigate(to: ToSleep(audioRecorder: audioRecorder, sleepRecording: sleepRecording, bleManager: bleManager), when: $willMoveToNextScreen)
        
    }
}

struct CalibrationStart_Previews: PreviewProvider {
    static var previews: some View {
        CalibrationStart(bleManager: BLEManager(), audioRecorder: AudioRecorder(), sleepRecording: SleepRecording())
    }
}
