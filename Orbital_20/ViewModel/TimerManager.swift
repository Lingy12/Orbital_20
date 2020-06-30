//
//  TimerManager.swift
//  Orbital_20
//
//  Created by 张远星 on 24/6/20.
//  Copyright © 2020 Jerry Lin. All rights reserved.
//

import Foundation
import SwiftUI

class TimerManager: ObservableObject {
    
    @Published var timerMode: TimerMode = .initial
    @Published var secondsLeft:Int
    @ObservedObject var task:Task
    
    init(task:Task) {
        let defaults = UserDefaults.standard
        self.task = task
        print(task.duration)
        defaults.set(task.duration * 3600,forKey: "timerLength")
        self.secondsLeft = Int(task.duration) * 3600
    }
    
    var timer = Timer()
//
//    func setTimerLength(minutes: Int) {
//        let defaults = UserDefaults.standard
//        defaults.set(minutes, forKey: "timerLength")
//        secondsLeft = minutes
//    }
    
    func start() {
        timerMode = .running //trigger the running mode
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
            if (self.secondsLeft == 0) {
                self.reset()
            }
            self.secondsLeft -= 1
        }
            
        )
    }
    
    func reset() {
        self.timerMode = .initial
        self.secondsLeft = UserDefaults.standard.integer(forKey: "timerLength")
        timer.invalidate()
    }
    
    func pause() {
        self.timerMode = .paused
        timer.invalidate()
    }
    
}

