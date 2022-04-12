//
//  PopUpAudioPlayer.swift
//  SleepGlove
//
//  Created by Catherine Livingston on 4/10/22.
//

import SwiftUI

struct PopUpAudioPlayer: View {
    var bletoAudio : BLEtoAudio
    
    init(bleManager: BLEManager, audioRecorder: AudioRecorder) {
        self.bletoAudio = BLEtoAudio(audioRecorder: audioRecorder, bleManager: bleManager)
    }
    
    var body: some View {
        Image(systemName: "speaker.2.fill")
            .resizable()
            .frame(width: 50, height: 50)
    }
}

struct PopUpAudioPlayer_Previews: PreviewProvider {
    static var previews: some View {
        PopUpAudioPlayer(bleManager: BLEManager(), audioRecorder: AudioRecorder())
    }
}
