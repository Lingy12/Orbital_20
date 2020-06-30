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
                }) {
                    Image(systemName: "pause.circle")
                    Text("Pause")
                }
            }
        }
    }
}

