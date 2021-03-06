//
//  RecordViewController.swift
//  PitchPerfect
//
//  Created by Ranieri Aguiar on 08/01/19.
//  Copyright © 2019 Ranieri. All rights reserved.
//

import UIKit
import AVFoundation

class RecordViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet var btnRecord: UIButton!
    @IBOutlet var btnStop: UIButton!
    
    @IBOutlet var lbStatus: UILabel!
    
    var session: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    let identifier = "stopRecording"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView(isRecording: false)
    }
    
    func setupView(isRecording: Bool) {
        btnRecord.isEnabled = !isRecording
        btnStop.isEnabled = isRecording
        lbStatus.text = isRecording ? "gravando..." : "toque para gravar"
    }
    
    func recordAudio() {
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        try! session.setActive(true, options: .notifyOthersOnDeactivation)
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        setupView(isRecording: false)
        if flag {
            performSegue(withIdentifier: identifier, sender: audioRecorder.url)
        } else {
            lbStatus.text = "erro ao gravar!"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == identifier {
            let view = segue.destination as! PlayViewController
            let recordedAudioURL = sender as! URL
            view.recordedAudioURL = recordedAudioURL
        }
    }
    
    @IBAction func btnRecordAction(_ sender: UIButton) {
        setupView(isRecording: true)
        recordAudio()
    }
    
    @IBAction func btnStopAction(_ sender: UIButton) {
        audioRecorder.stop()
        let session = AVAudioSession.sharedInstance()
        try! session.setActive(false)
    }
}
