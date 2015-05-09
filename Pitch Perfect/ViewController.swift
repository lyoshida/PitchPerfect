//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Luis Yoshida on 5/8/15.
//  Copyright (c) 2015 Msen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // weak and strong keywords has to do with memory management
    // the ! means optional value.
    @IBOutlet weak var recordingInProgress: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        // Hide the stop button
        stopButton.hidden = true
        recordButton.enabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // The IBAction (Interface Builder Action) tells that this function is linked to the storyboard.
    @IBAction func recordAudio(sender: UIButton) {
        //TODO: Show text "recording in progress"
        //TODO: Record the user's voice

        recordingInProgress.hidden = false
        stopButton.hidden = false
        recordButton.enabled = false
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        recordingInProgress.hidden = true
        stopButton.hidden = true
        recordButton.enabled = true
    }
}

