//
//  StepFivePrompt.swift
//  SleepGlove
//
//  Created by Catherine Livingston on 4/1/22.
//

import SwiftUI

struct StepFivePrompt: View {
    @State private var hasCallibrated = false
    @State private var willMoveToNextScreen = false
    @ObservedObject var audioRecorder: AudioRecorder
    @ObservedObject var sleepRecording: SleepRecording
    @ObservedObject var bleManager: BLEManager
    
    var body: some View {
        VStack {
            Text("Time to callibrate the sleep measuring device.")
                .font(.system(size: 30, weight: .bold))
                .padding([.top], 30)
            Text("With the wristband on, close your hand around the cylinder and relax for 30 seconds to get your baseline measurements.")
                .padding()
                .font(.system(size: 20, weight: .regular))
                .frame(maxWidth: .infinity, alignment: .leading)
            if bleManager.incomingMessage == "finishedCallibration" {
                Text("The device is callibrated! When you are ready to sleep, press the button below.")
                    .padding()
                    .font(.system(size: 15, weight: .regular))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Button(action: {
                    bleManager.sendText(text: "startSleep")
                    audioRecorder.playRecording(record: audioRecorder.getToSleepRecording())
                    self.willMoveToNextScreen = true;
                }) {
                    Text("Go to Sleep")
                        .fontWeight(.bold)
                        .padding(20)
                        .foregroundColor(.white)
                        .frame(width: 200)
                }
                    .padding()
                    .disabled(!hasCallibrated)
                    .buttonStyle(MyButtonStyle())
                    .shadow(radius: 5.0)
            } else {
                Button(action: {
                    self.bleManager.sendText(text: "startCalibration")
                    self.hasCallibrated = true
                }) {
                    Text("Callibrate")
                        .fontWeight(.bold)
                        .padding(20)
                        .foregroundColor(.white)
                        .frame(width: 200)
                }
                    .padding()
                    .disabled(hasCallibrated)
                    .buttonStyle(MyButtonStyle())
                    .shadow(radius: 5.0)
            }
            
        }.navigate(to: ToSleep(audioRecorder: audioRecorder, sleepRecording: sleepRecording, bleManager: bleManager), when: $willMoveToNextScreen)
    }
}

struct StepFivePrompt_Previews: PreviewProvider {
    static var previews: some View {
        StepFivePrompt(audioRecorder: AudioRecorder(), sleepRecording: SleepRecording(), bleManager: BLEManager())
    }
}
