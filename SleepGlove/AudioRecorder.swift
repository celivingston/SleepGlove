//
//  AudioRecorder.swift
//  SleepGlove
//
//  Created by Catherine Livingston on 3/30/22.
//

import Foundation

import Foundation
import SwiftUI
import Combine
import AVFoundation
class AudioRecorder: ObservableObject {
    let objectWillChange = PassthroughSubject<AudioRecorder, Never>()
    var audioRecorder: AVAudioRecorder!
    var recordings = [Recording]()
    var recording = false {
            didSet {
                objectWillChange.send(self)
            }
        }
    func startRecording() {
        let recordingSession = AVAudioSession.sharedInstance()
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
        } catch {
            print("Failed to set up recording session")
        }
        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let audioFilename = documentPath.appendingPathComponent("\(Date().toString(dateFormat: "dd-MM-YY_'at'_HH:mm:ss")).m4a")
        print(audioFilename)
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.record()
            recording = true
            recordings.append(Recording(fileURL: audioFilename, createdAt: Date()))
        } catch {
            print("Could not start recording")
        }
    }
    func stopRecording() -> Recording? {
        audioRecorder.stop()
        recording = false
        if let lastRecording = recordings.last {
            return lastRecording
        } else {
            print("no recording")
            return nil
        }
        
    }
}

extension Date {
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
