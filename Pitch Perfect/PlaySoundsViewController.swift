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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if var filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3")
        {
            var filePathUrl = NSURL.fileURLWithPath(filePath)
            audioPlayer = AVAudioPlayer(contentsOfURL: filePathUrl, error: nil)
            audioPlayer.enableRate = true
            
        } else {
            println("File not found.")
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playSlowAudio(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.rate = 0.5
        
        // Resets audio playback to the beginning
        audioPlayer.currentTime = 0
        audioPlayer.play()
        
    }

    @IBAction func playFastAudio(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.rate = 1.5
        
        // Resets audio playback to the beginning
        audioPlayer.currentTime = 0
        audioPlayer.play()
    }
    @IBAction func stopAudio(sender: UIButton) {
        audioPlayer.stop()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
