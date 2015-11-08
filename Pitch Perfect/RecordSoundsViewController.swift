//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Luis Yoshida on 5/8/15.
//  Copyright (c) 2015 Msen. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    // weak and strong keywords has to do with memory management
    // the ! means optional value.
    @IBOutlet weak var recordingInProgress: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    var audioRecorder:AVAudioRecorder!
    var recordedAudio: RecordedAudio!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        stopButton.hidden = true
        recordButton.enabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // The IBAction (Interface Builder Action) tells that this function is linked to the storyboard.
    @IBAction func recordAudio(sender: UIButton) {

        recordingInProgress.text = "Record in progress"
        stopButton.hidden = false
        recordButton.enabled = false
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] 
        let currentDateTime = NSDate()
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime) + ".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)

        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        } catch _ {
        }
        
        let recordSettings: [String: AnyObject] = [AVEncoderAudioQualityKey: AVAudioQuality.Min.rawValue,
                              AVEncoderBitRateKey: 16,
                              AVNumberOfChannelsKey: 2,
                              AVSampleRateKey: 44100.0]

        
        audioRecorder = try? AVAudioRecorder(URL: filePath!, settings: recordSettings)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if(flag) {
            recordedAudio = RecordedAudio(filePathUrl: recorder.url, title: recorder.url.lastPathComponent!)
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        } else {
            print("Recording was not successful.")
            recordButton.enabled = true
            stopButton.hidden = true
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording") {
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! RecordedAudio
            playSoundsVC.receivedAudio = data
        }
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        recordingInProgress.text = "Tap to record"
        stopButton.hidden = true
        recordButton.enabled = true
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setActive(false)
        } catch _ {
        }
        
        
    }
}

