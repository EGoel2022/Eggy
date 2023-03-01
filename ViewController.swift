//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player : AVAudioPlayer!
    var timer : Timer!
    
    @IBOutlet weak var doneLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    let eggTimer = ["Soft" : 300, "Medium" : 420, "Hard" : 600]
    
   //MARK: - Timer Button Pressed
    
    @IBAction func buttonPressed(_ sender: UIButton) {
     
        if timer != nil {
            timer.invalidate()
            progressView.progress = 0
        }
        
        var secs = 1
        var hardnessSelected = (eggTimer[sender.currentTitle!]!)
        let seconds = hardnessSelected
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] (Timer) in
            if hardnessSelected > 0 {
                doneLabel.text = ("\(hardnessSelected) secs to go...")
                hardnessSelected -= 1
                progressView.progress = Float(secs) / Float(seconds)
                secs += 1
                
            } else {
                playAlarm()
                Timer.invalidate()
            }
        }
        
    }
    
    //MARK: - Cancel Button Pressed
    
    @IBAction func cancelTimerPressed(_ sender: UIButton) {
        if timer != nil {
            timer.invalidate()
            progressView.progress = 0
            doneLabel.text = "Cancelled" }
        else {
            doneLabel.text = "Select your egg timer."
        }
    }
    
    
    //MARK: - Playing Alarm
    
    func playAlarm()  {
        if let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") {
            player = try! AVAudioPlayer(contentsOf: url)
            player.play()
            
            doneLabel.text = "DONE!" }
        else {
            print("Error finding the alarm sound file.")
        }
        
    }
    
}

