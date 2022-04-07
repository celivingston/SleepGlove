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
class AudioRecorder: NSObject, ObservableObject {
    let objectWillChange = PassthroughSubject<AudioRecorder, Never>()
    var audioRecorder: AVAudioRecorder!
    var audioPlayer = AVAudioPlayer()
    var recordings = [Recording]()
    var recording = false {
            didSet {
                objectWillChange.send(self)
            }
        }
    @State var isPlaying : Bool = false
    
    override init() {
        super.init()
        fetchRecordings()
        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let dataPath = documentPath.appendingPathComponent("ToSleepRecordings")
        if !FileManager.default.fileExists(atPath: dataPath.path) {
            do {
                try FileManager.default.createDirectory(atPath: dataPath.path, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print(error.localizedDescription)
            }
        }
        let dataPath2 = documentPath.appendingPathComponent("ToWakeRecordings")
        if !FileManager.default.fileExists(atPath: dataPath2.path) {
            do {
                try FileManager.default.createDirectory(atPath: dataPath2.path, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print(error.localizedDescription)
            }
        }
        let dataPath3 = documentPath.appendingPathComponent("DreamRecordings")
        if !FileManager.default.fileExists(atPath: dataPath3.path) {
            do {
                try FileManager.default.createDirectory(atPath: dataPath3.path, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print(error.localizedDescription)
            }
        }
        
    }
    
    func startRecording(pathComponent: String?) {
        let recordingSession = AVAudioSession.sharedInstance()
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
        } catch {
            print("Failed to set up recording session")
        }
        var documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        if pathComponent != nil {
            documentPath = documentPath.appendingPathComponent(pathComponent ?? "");
        }
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
            print(recordings.last)
        } catch {
            print("Could not start recording")
        }
    }
    func stopRecording() -> Recording? {
        print("stopping recording")
        audioRecorder.stop()
        self.recording = false
        if let lastRecording = recordings.last {
            print(lastRecording)
            return lastRecording
        } else {
            print("no recording")
            return nil
        }
        
    }
    func fetchRecordings() {
        recordings.removeAll()
            
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let directoryContents = try! fileManager.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil)
        for audio in directoryContents {
            let recording = Recording(fileURL: audio, createdAt: getCreationDate(for: audio))
            recordings.append(recording)
        }
        
        recordings.sort(by: { $0.createdAt.compare($1.createdAt) == .orderedAscending})
                
        objectWillChange.send(self)
    }
    
    func fetchTodaysRecordings() {
        recordings.removeAll()
        
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let directoryContents = try! fileManager.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil)
        for audio in directoryContents {
            let recording = Recording(fileURL: audio, createdAt: getCreationDate(for: audio))
            if recording.createdAt >= (recording.createdAt - TimeInterval(72000)) {
                recordings.append(recording)
            }
        }
        
        recordings.sort(by: { $0.createdAt.compare($1.createdAt) == .orderedAscending})
                
        objectWillChange.send(self)

    }
    
    func playRecording(record: Recording) {
        self.isPlaying = true;
        do {
            self.audioPlayer = try AVAudioPlayer(contentsOf: record.fileURL)
            self.audioPlayer.prepareToPlay()
            self.audioPlayer.play()
        } catch {
            print("Error in playing file")
        }

        
    }
    
    func getCreationDate(for file: URL) -> Date {
        if let attributes = try? FileManager.default.attributesOfItem(atPath: file.path) as [FileAttributeKey: Any],
            let creationDate = attributes[FileAttributeKey.creationDate] as? Date {
            return creationDate
        } else {
            return Date()
        }
    }
    
    func getToSleepRecording() -> Recording {
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("ToSleepRecordings", isDirectory: true)
        let directoryContents = try! fileManager.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil)
        var latestRecording: Recording = Recording(fileURL: directoryContents[0], createdAt: getCreationDate(for: directoryContents[0]))
        for audio in directoryContents {
            let recording = Recording(fileURL: audio, createdAt: getCreationDate(for: audio))
            if recording.createdAt > latestRecording.createdAt {
                latestRecording = recording
            }
        }
        return latestRecording
    }
    
    func getToWakeRecording() -> Recording {
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("ToWakeRecordings", isDirectory: true)
        let directoryContents = try! fileManager.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil)
        var latestRecording: Recording = Recording(fileURL: directoryContents[0], createdAt: getCreationDate(for: directoryContents[0]))
        for audio in directoryContents {
            let recording = Recording(fileURL: audio, createdAt: getCreationDate(for: audio))
            if recording.createdAt > latestRecording.createdAt {
                latestRecording = recording
            }
        }
        return latestRecording
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
