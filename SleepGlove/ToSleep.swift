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
            if bleManager.incomingMessage == "sleepMessage" {
                PopUpAudioPlayer(bleManager: self.bleManager, audioRecorder: self.audioRecorder)
                //print("wakeUp")
                //audioRecorder.playRecording(record: sleepRecording.toWakeRecording)
            }
            if bleManager.incomingMessage == "wakeUp" {
                PopUpAudioPlayer(bleManager: self.bleManager, audioRecorder: self.audioRecorder)
                
            }
        }
        
    }
}

struct ToSleep_Previews: PreviewProvider {
    static var previews: some View {
        ToSleep(audioRecorder: AudioRecorder(), sleepRecording: SleepRecording(), bleManager: BLEManager())
    }
}
