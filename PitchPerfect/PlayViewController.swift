//
//  PlayViewController.swift
//  PitchPerfect
//
//  Created by Ranieri Aguiar on 08/01/19.
//  Copyright © 2019 Ranieri. All rights reserved.
//

import UIKit
import AVFoundation

class PlayViewController: UIViewController {
    
    @IBOutlet var btnSlow: UIButton!
    @IBOutlet var btnFast: UIButton!
    @IBOutlet var btnLow: UIButton!
    @IBOutlet var btnHigh: UIButton!
    @IBOutlet var btnEcho: UIButton!
    @IBOutlet var btnReverb: UIButton!
    @IBOutlet var btnStop: UIButton!
    
    var recordedAudioURL: URL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case slow = 0, fast, vader, chipmunk, echo, reverb
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        
        btnSlow.imageView?.contentMode = .scaleAspectFit
        btnFast.imageView?.contentMode = .scaleAspectFit
        btnLow.imageView?.contentMode = .scaleAspectFit
        btnHigh.imageView?.contentMode = .scaleAspectFit
        btnEcho.imageView?.contentMode = .scaleAspectFit
        btnReverb.imageView?.contentMode = .scaleAspectFit
        btnStop.imageView?.contentMode = .scaleAspectFit
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI(.notPlaying)
    }
    
    @IBAction func btnPlayAction(_ sender: UIButton) {
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        configureUI(.playing)
    }
    
    @IBAction func btnStopAction(_ sender: UIButton) {
        stopAudio()
    }
}
