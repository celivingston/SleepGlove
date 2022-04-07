//
//  ToSleep.swift
//  SleepGlove
//
//  Created by Catherine Livingston on 4/6/22.
//

import SwiftUI

struct ToSleep: View {
    @ObservedObject var audioRecorder: AudioRecorder
    @ObservedObject var sleepRecording: SleepRecording
    @ObservedObject var bleManager: BLEManager
    
    var body: some View {
        VStack {
            Text("Make sure your volume is up.")
            Image(systemName: "speaker.2.fill")
            if bleManager.incomingMessage == "wakeUp" {
                //print("wakeUp")
                //audioRecorder.playRecording(record: sleepRecording.toWakeRecording)
            }
        }
        
    }
}

struct ToSleep_Previews: PreviewProvider {
    static var previews: some View {
        ToSleep(audioRecorder: AudioRecorder(), sleepRecording: SleepRecording(), bleManager: BLEManager())
    }
}
