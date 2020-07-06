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
    
    @Environment(\.managedObjectContext) var context
    @Published var timerMode: TimerMode = .initial
    @Published var secondsLeft:Int
    @ObservedObject var task:Task
    @FetchRequest(entity: Module.entity(), sortDescriptors: []) var modList:FetchedResults<Module>
    var startTime:Date?
    
    init(task:Task) {
        let defaults = UserDefaults.standard
        self.task = task
        defaults.set(Int(task.duration) * 60,forKey: "timerLength")
        self.secondsLeft = Int(task.duration) * 60
    }
    
    var timer = Timer()
    
    
    func start() {
        timerMode = .running //trigger the running mode
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
            if (self.secondsLeft == 0) {
                self.end()
            }
            self.secondsLeft -= 1
        })
        
        self.startTime = Date()
    }
    
    func set(time:Int) {
        let defaults = UserDefaults.standard
        defaults.set(time * 60, forKey: "timerLength")
        self.secondsLeft = time
    }
    
    func reset() {
        self.timerMode = .initial
        self.secondsLeft = UserDefaults.standard.integer(forKey: "timerLength")
        timer.invalidate()
    }
    
    func end() {
        self.timerMode = .end
        self.secondsLeft = 0
        timer.invalidate()
    }
    
    func pause() {
        self.timerMode = .paused
        timer.invalidate()
    }
    

}

