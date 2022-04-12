//
//  StepFivePrompt.swift
//  SleepGlove
//
//  Created by Catherine Livingston on 4/1/22.
//

import SwiftUI

struct StepFivePrompt: View {
    @State private var willMoveToNextScreen = false
    @ObservedObject var audioRecorder: AudioRecorder
    @ObservedObject var sleepRecording: SleepRecording
    @ObservedObject var bleManager: BLEManager
    
    var body: some View {
        VStack {
            Text("Time to position the device for sleep!")
                .font(.system(size: 30, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding([.top], 30)
            Text("Place the band on the front of your wrist, back of your wrist, or tip of your bicep. Make sure the band is fastened tightly. ")
                .padding()
                .font(.system(size: 20, weight: .regular))
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("The position of the wire is not important, but remember you will be sleeping with it. ")
                .padding()
                .font(.system(size: 20, weight: .regular))
                .frame(maxWidth: .infinity, alignment: .leading)

            Text("Wrap your hand around the cylinder to cover the white square. Get comfortable with the positioning. We recommend lining your thumb up with the vertical white seam. ")
                .padding()
                .font(.system(size: 20, weight: .regular))
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            Button(action: {
                self.bleManager.sendText(text: "startCalibration")
                self.willMoveToNextScreen = true
            }) {
                Text("Ready!")
                    .fontWeight(.bold)
                    .padding(20)
                    .foregroundColor(.white)
                    .frame(width: 200)
            }
                .padding()
                .buttonStyle(MyButtonStyle())
                .shadow(radius: 5.0)
            PromptProgression(promptNumber: 4)
        }.navigate(to: CalibrationStart(bleManager: bleManager, audioRecorder: audioRecorder, sleepRecording: sleepRecording), when: $willMoveToNextScreen)
    }
}

struct StepFivePrompt_Previews: PreviewProvider {
    static var previews: some View {
        StepFivePrompt(audioRecorder: AudioRecorder(), sleepRecording: SleepRecording(), bleManager: BLEManager())
    }
}
