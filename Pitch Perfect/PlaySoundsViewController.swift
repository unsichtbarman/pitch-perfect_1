//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Colin Fraser on 22/05/2015.
//  Copyright (c) 2015 Colin Fraser. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
   
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playSlowAudio(sender: UIButton) {
       
        // stopAudio() // make sure all audio processes are stopped
        playAudioWithSpeed(0.5) // play with half speed
        
        
    }
    
    
    @IBAction func playFastAudio(sender: UIButton) {
        
        playAudioWithSpeed(2) // play with double speed
        
    }
    
    
    @IBAction func playChipmunkAudio(sender: UIButton) {

        playAudioWithVariablePitch(1000)
        
    }
   
    @IBAction func playDarthVader(sender: UIButton) {
        
        playAudioWithVariablePitch(-1000)
        
    }
    
    
    func stopAudio(){
    // stops all audio processes
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
    }
    
    func playAudioWithSpeed(speed: Float){
        
        stopAudio() // stop all audio processes before we do anything
        audioPlayer.rate = speed // assign the value of rate
        audioPlayer.currentTime = 0.0 // reset the audioPlayer to the beginning
        audioPlayer.play()
        
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        // play Audio with variable pitch - initialises with number for pitch
        
        stopAudio()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    
    @IBAction func stopAudio(sender: UIButton) {
    
        stopAudio()
    
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
