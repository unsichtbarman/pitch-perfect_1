//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Colin Fraser on 19/05/2015.
//  Copyright (c) 2015 Colin Fraser. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordingInProgress: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var tapToRecord: UILabel!
    
    
    // set up global variables of class AVAudioRecorder and RecordedAudio
    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        // Hide the Stop button and show the Record button
        stopButton.hidden = true
        recordButton.enabled = true
        tapToRecord.hidden = false
    }

    @IBAction func recordAudio(sender: UIButton) {
        // Show text "Recording in progress", display Stop button and remove "Tap to record" and record button.
        
        recordButton.enabled = false
        stopButton.hidden = false
        tapToRecord.hidden = true
        recordingInProgress.hidden = false
        
        // Record user's voice
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask, true)[0] as! String
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        // Set up audio session
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        // Initialise and prepare the recorder
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
      
        
        if (flag) {
        // Save recorded audio
            
            recordedAudio = RecordedAudio(filePath: recorder.url!, title: recorder.url.lastPathComponent!) // create instance of RecordedAudio class
        
        // Move to the next scene to perform segue.
        
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)  // recordedAudio will begin the segue
        
        } else {
            println("Recording not successful")
            recordButton.enabled = true
            stopButton.hidden = true
            
            
        }
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "stopRecording" {
        
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! RecordedAudio
            playSoundsVC.receivedAudio = data
            
        }
        
    }
    
    @IBAction func stopAudio(sender: UIButton) {
    
        recordingInProgress.hidden = true
        
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    
    }
    
    
}

