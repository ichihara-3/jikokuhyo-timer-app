//
//  ContentView.swift
//  jikokuhyo-timer
//
//  Created by Kotaro Ichihara on 2020/03/24.
//  Copyright © 2020 Kotaro Ichihara. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Jikoku Hyo Timer")
            .font(.title)
            .fontWeight(.heavy)
            .foregroundColor(.green)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class ViewController: UIViewController {
    
    @IBOutlet var timerMinute: UILabel!
    @IBOutlet var timerSecond: UILabel!
    @IBOutlet var timerMSec: UILabel!
    
    var timer: Timer!
    var startTime = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red:0.9, green:1.0, blue: 0.9, alpha:1.0)
    }
    
    @IBAction func startTimer() {
        
        if timer != nil {
            timer.invalidate()
        }
        
        timer = Timer.scheduledTimer(
            timeInterval: 0.01,
            target: self,
            selector: #selector(self.timerCounter),
            userInfo: nil,
            repeats: true)
    }
    
    @IBAction func stopTimer(sender : AnyObject) {
        if timer != nil {
            timer.invalidate()
            
            timerMinute.text = "00"
            timerSecond.text = "00"
            timerMSec.text = "00"
        }
    }
    
    @objc func timerCounter() {
        let currentTime = Date().timeIntervalSince(startTime)
        
        let minute = (Int)(fmod((currentTime/60), 60))
        let second = (Int)(fmod(currentTime, 60))
        let msec = (Int)((currentTime - floor(currentTime))*100)
        
        timerMinute.text = String(format:"%02d", minute)
        timerSecond.text = String(format: "%02d", second)
        timerMSec.text = String(format: "%02d", msec)
        
        print(timerMinute.text ?? "00", timerSecond.text ?? "00", timerMSec.text ?? "00")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        startTimer()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        timer.invalidate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

