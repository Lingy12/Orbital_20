//
//  TimerView.swift
//  Orbital_20
//
//  Created by Jerry Lin on 23/6/20.
//  Copyright © 2020 Jerry Lin. All rights reserved.
//

import SwiftUI

struct TimerView: View {
    @ObservedObject var timerManager:TimerManager
    @FetchRequest(entity: Module.entity(), sortDescriptors: []) var modList:FetchedResults<Module>
    @FetchRequest(entity: Task.entity(), sortDescriptors: []) var taskList:FetchedResults<Task>
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        VStack {
            Text("Timer Remaining:").bold().foregroundColor(.blue)
            Text(secondsToHourMinSec(seconds: timerManager.secondsLeft))
            
            if timerManager.timerMode == .initial {
                Button(action:{
                    self.timerManager.start()
                }) {
                    VStack {
                        Image(systemName: "play.circle")
                        Text("Start to study")
                    }.frame(alignment:.center)
                }
            } else if(timerManager.timerMode == .paused) {
                HStack {
                    Button(action: {
                        self.timerManager.start()
                    }) {
                            VStack {
                                Image(systemName: "goforward")
                                Text("Continue")
                            }
                    }
                    
                    Button(action:{
                        self.timerManager.reset()
                    }) {
                        VStack {
                            VStack {
                                Image(systemName: "gobackward")
                                Text("Reset")
                            }
                        }
                    }
                }
            } else {
                Button(action:{
                    self.timerManager.pause()
                    self.updateModuleTIme(time: Date().timeIntervalSince(self.timerManager.startTime ?? Date()))
                }) {
                    Image(systemName: "pause.circle")
                    Text("Pause")
                }
            }
        }
    }
    
    
    func getAssociateModuleIndex() -> Int? {
        for index in self.modList.indices {
            if self.modList[index].moduleName == self.timerManager.task.modName {
                return index
            }
        }
        
        return nil
    }
    
    func updateModuleTIme(time:TimeInterval) {
        let index = self.getAssociateModuleIndex()
        let spent = self.modList[index!].spentTime
        self.modList[index!].spentTime = spent + time
        try? self.context.save()
    }
    
}

