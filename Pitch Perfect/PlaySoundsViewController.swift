//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Luis Yoshida on 10/05/15.
//  Copyright (c) 2015 Msen. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine = AVAudioEngine()
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioPlayer = try? AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = try? AVAudioFile(forReading: receivedAudio.filePathUrl)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playSlowAudio(sender: UIButton) {
        playAudioWithVariableRate(0.5)
        
    }

    @IBAction func playFastAudio(sender: UIButton) {
        playAudioWithVariableRate(1.5)
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        stopAudioPlayback()
    }
    
    func playAudioWithVariableRate(rate: Float) {
        stopAudioPlayback()
        audioPlayer.rate = rate
        
        // Resets audio playback to the beginning
        audioPlayer.currentTime = 0
        audioPlayer.play()
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        stopAudioPlayback()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        do {
            try audioEngine.start()
        } catch _ {
        }
        
        audioPlayerNode.play()
    }
    
    func stopAudioPlayback() {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    
}
