//
//  ViewController.swift
//  PomodoroTimer
//
//  Created by matsumoto miharu on 2018/12/26.
//  Copyright © 2018年 ポモポモ. All rights reserved.
//

import UIKit
import AVFoundation
import RealmSwift

class ViewController: UIViewController {

    var audioPlayer: AVAudioPlayer!
    @IBOutlet weak var miniteLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var todoText: UITextField!
    private var timer = Timer()
    private var count = 30 * 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @IBAction func backToTop(segue: UIStoryboardSegue) {
    }
    
    @IBAction func startTimer(_ sender: Any) {
        if !timer.isValid {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        }
        if self.startButton.currentTitle == "Start" {
            startButton.setTitleColor(UIColor(red: 0, green: 122 / 255, blue: 1, alpha: 1), for: .normal)
            startButton.setTitle("Stop", for: .normal)
            time.text = "集中時間"
            time.backgroundColor = UIColor(red: 0, green: 122 / 255, blue: 1, alpha: 1)
        } else if self.startButton.currentTitle == "Stop" {
            //データベース
            let doHistory = DoHistory()
            let doTime = 30 * 60 - count
            let minite = doTime / 60
            var second = ""
            if doTime % 60 < 10 {
                second = "0" + String(doTime % 60)
            }
            doHistory.save(title: todoText.text!, doTime: String(minite) + ":" + second)
            
            timer.invalidate()
            count = 30 * 60
            miniteLabel.text = String(30)
            secondLabel.text = "0" + String(0)
            startButton.setTitleColor(UIColor(red: 0, green: 122 / 255, blue: 1, alpha: 1), for: .normal)
            startButton.setTitle("Start", for: .normal)
        }
    }
    
    @objc private func updateTimer() {
        if count == 0 {
            //データベース
            let doHistory = DoHistory()
            doHistory.save(title: todoText.text!, doTime: "30:00")
            
            timer.invalidate()
            count = 30 * 60
            startButton.setTitleColor(UIColor(red: 0, green: 122 / 255, blue: 1, alpha: 1), for: .normal)
            startButton.setTitle("Start", for: .normal)
        } else if count == 5 * 60 {
            time.text = "休憩時間"
            time.backgroundColor = UIColor(red: 199 / 255, green: 1, blue: 136 / 255, alpha: 1)
            count -= 1
        } else {
            count -= 1
        }
        let miniteCount = count / 60
        let secondCount = count % 60
        
        if miniteCount < 10 {
            miniteLabel.text = "0" + String(miniteCount)
        } else {
            miniteLabel.text = String(miniteCount)
        }
        if secondCount < 10 {
            secondLabel.text = "0" + String(secondCount)
        } else {
            secondLabel.text = String(secondCount)
        }
    }
}

