//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Ayako Doue on 5/30/15.
//  Copyright (c) 2015 aya. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
    var audioReverb: AVAudioUnitReverb!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    @IBAction func playSlowAudio(sender: UIButton) {
        // Play audio slowly here
        stopAndResetAudio()
        
        audioPlayer.currentTime = 0.0
        audioPlayer.rate = 0.5
        
        audioPlayer.play()
    }

    @IBAction func playFastAudio(sender: UIButton) {
        // Play fast audio here
        stopAndResetAudio()
        
        audioPlayer.currentTime = 0.0
        audioPlayer.rate = 1.5
        
        audioPlayer.play()
    }
    
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        stopAndResetAudio()
        playAudioWithVariablePitch(1000)
    }
    
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        stopAndResetAudio()
        playAudioWithVariablePitch(-1000)
    }
    
    @IBAction func playReverbAudio(sender: UIButton) {
        stopAndResetAudio()
        playAudioWithReverb(80)
    }
    
    
    func playAudioWithVariablePitch(pitch: Float) {
        
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
    
    // Play Audio with Reverb
    func playAudioWithReverb(reverbRate: Float){
        
        stopAndResetAudio()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        // Set reverb effect
        var audioReverb = AVAudioUnitReverb()
        audioReverb.loadFactoryPreset(.LargeRoom)
        audioReverb.wetDryMix = reverbRate
        
        audioEngine.attachNode(audioReverb)
        
        // Connect audioPlayerNode and audioReverb to AVAudioEngine
        audioEngine.connect(audioPlayerNode, to: audioReverb, format: nil)
        audioEngine.connect(audioReverb, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func stopAudio(sender: UIButton) {
        // Stop audio
        audioPlayer.stop()
        audioEngine.stop()
    
    }
    
    // Stops current audio and reset
    func stopAndResetAudio() {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
}
