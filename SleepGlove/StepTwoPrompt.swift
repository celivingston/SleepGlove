//
//  StepTwoPrompt.swift
//  SleepGlove
//
//  Created by Catherine Livingston on 3/30/22.
//

import SwiftUI
struct StepTwoPrompt: View {
    @State private var time: String = ""
    @State private var willMoveToNextScreen = false
    @ObservedObject var sleepRecording: SleepRecording
    
    var body: some View {
        VStack {
            Text("Enter time until sleep.")
                .font(.system(size: 30, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.leading, .trailing])
                .padding([.bottom], 5)
            Text("This is your best guess. Try to overestimate by a few minutes.")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.leading, .trailing])
            TextField("Enter number of minutes", text: $time)
                .padding()
                .keyboardType(.numberPad)
            Button(action: {
                sleepRecording.minutesToSleep = Int(time) ?? 15
                self.willMoveToNextScreen = true
            }) {
                Text("Next")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width: 200)
                    .cornerRadius(30)
                    .padding()
                    
            }   .padding()
                .shadow(radius: 5.0)
                .disabled(time=="")
                .buttonStyle(MyButtonStyle())
        }.textFieldStyle(.roundedBorder).navigate(to: StepThreePrompt(audioRecorder: AudioRecorder(), sleepRecording: sleepRecording), when: $willMoveToNextScreen)
    }
    
}

struct StepTwoPrompt_Previews: PreviewProvider {
    static var previews: some View {
        StepTwoPrompt(sleepRecording: SleepRecording())
    }
}
