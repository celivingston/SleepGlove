//
//  StepFourPrompt.swift
//  SleepGlove
//
//  Created by Catherine Livingston on 3/30/22.
//

import SwiftUI

struct StepFourPrompt: View {
    @ObservedObject var audioRecorder: AudioRecorder
    @ObservedObject var sleepRecording: SleepRecording
    @ObservedObject var bleManager: BLEManager
    @State private var willMoveToNextScreen = false
    @State private var hasRecorded = false
    var body: some View {
        VStack {
            Text("Now, please record a sleep message. ")
                .padding([.leading, .trailing], 15)
                .padding([.top], 40)
                .font(.system(size: 20, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Tap the Record button and read the below message. This recording will be played to wake you up from the hypnogoia sleep state. ")
                .padding([.leading, .trailing], 15)
                .padding([.top], 5)
                .font(.system(size: 15, weight: .regular))
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            Text("Press record and say the following...")
                .font(.system(size: 15))
            Text("\"You can fall asleep now. \n Remember to dream about ().\"")
                .padding()
                .background(Color.gray.opacity(0.25))
                .cornerRadius(10)
            if audioRecorder.recording == false {
                Button(action: {self.audioRecorder.startRecording(pathComponent: "ToSleepRecordings")}) {
                    Image(systemName: "circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipped()
                        .foregroundColor(.red)
                        .overlay(Text("RECORD").foregroundColor(Color.white).font(.system(size: 17, weight: .bold)), alignment: .center)
                        .shadow(radius: 10)
                }.padding([.top, .bottom], 30)
            } else {
                Button(action: {
                    sleepRecording.addToSleepRecording(record: self.audioRecorder.stopRecording())
                    self.hasRecorded = true
                }) {
                    Image(systemName: "stop.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipped()
                        .foregroundColor(.red)
                        .overlay(Text("STOP").foregroundColor(Color.white).font(.system(size: 17, weight: .bold)), alignment: .center)
                        .shadow(radius: 10)
                }.padding([.top, .bottom], 30)
            }
            Spacer()
            Text("If there are issues that occurred during your recording, please re-record by tapping the button again. ")
                .font(.system(size: 15, weight: .regular))
                .foregroundColor(hasRecorded ? Color.primary : Color.clear)
            Button(action: {
                if audioRecorder.recording == true {
                    sleepRecording.toSleepRecording = audioRecorder.stopRecording()
                }
                self.willMoveToNextScreen = true
            }) {
                Text("Next")
                    .fontWeight(.bold)
                    .padding(20)
                    .foregroundColor(.white)
                    .shadow(radius: 5.0)
                    .frame(width: 200)
            }
                .padding()
                .disabled(!hasRecorded)
                .buttonStyle(MyButtonStyle())
        }.navigate(to: StepFivePrompt(audioRecorder: audioRecorder, sleepRecording: sleepRecording, bleManager: bleManager), when: $willMoveToNextScreen)
    }
}

struct StepFourPrompt_Previews: PreviewProvider {
    static var previews: some View {
        StepFourPrompt(audioRecorder: AudioRecorder(), sleepRecording: SleepRecording(), bleManager: BLEManager())
    }
}
