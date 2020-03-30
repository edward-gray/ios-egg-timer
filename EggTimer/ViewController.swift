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
    
    var player: AVAudioPlayer?
    
    let eggTimes = ["Soft": 300, "Medium": 420, "Hard": 700]
    let eggTitles = ["Soft": "Soft Egg\n ON",
                     "Medium": "Medium Egg\n ON",
                     "Hard": "Hard Egg\n ON"]
    
    var secondsRemaining = 60
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    
    @IBOutlet weak var titleUILabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        reset()
        
        let hardness = sender.currentTitle!
        
        titleUILabel.text = eggTitles[hardness]!
        
        totalTime = eggTimes[hardness]!
        
        // now setting the timer
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if secondsPassed == totalTime {
            timer.invalidate()
            titleUILabel.text = "Done!"
            playAlarm()
        } else {
            secondsPassed += 1

            // handling progressBar
            let progress = Float(secondsPassed) / Float(totalTime)
            progressBar.progress = progress
            
            // for debug
            print("\(secondsPassed) seconds")
        }
    }
    
    func reset() {
        timer.invalidate()
        progressBar.progress = 0
        secondsPassed = 0
    }
    
    func playAlarm() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player!.play()
    }
    
}
