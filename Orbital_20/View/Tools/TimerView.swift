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

// VStack {
//            //- MARK: COUNTDOWN
//            VStack {
//                Text("Time Remaining:").bold().foregroundColor(.red)
//                // TODO: countdown time
//              //  Text(secondsToHourMinSec(seconds:timerManager.$secondsLeft)).bold().foregroundColor(.red)
//            }.scaleEffect(1.75)
//
//            Spacer()
//
//            //PauseButton
//            Text(timerManager.timerMode == .running ? "Pause" : "Continue").bold()
//                    .foregroundColor(.white)
//                    .padding(.all, 10)
//                    .padding([.leading, .trailing], 30)
//                    .background(Color.pink)
//                    .cornerRadius(20)
//                    .onTapGesture(perform: {
//                        if (self.timerManager.timerMode == .initial) {
//                            self.timerManager.setTimerLength(minutes: Int(self.task.duration))
//                        }
//                        self.timerManager.timerMode == .running
//                        ? self.timerManager.pause()
//                        : self.timerManager.start()
//                    })
//
//            //show restart bottom if paused
//            if timerManager.timerMode == .paused {
//                Image(systemName: "gobackward")
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 50, height: 50)
//                    .padding(.top, 40)
//                    .onTapGesture(perform: {
//                        self.timerManager.reset()
//                    })
//            }
//
//            //Select Time length
//            if timerManager.timerMode == .initial {
////                Picker(selection: $selectedPickerIndex, label: Text("")) {
////                    ForEach (0 ..< availableMinutes.count) {
////                        Text("\(self.availableMinutes[$0]) min")
////                    }
////                }.labelsHidden()
//                Text(secondsToHourMinSec(seconds: Int(self.task.duration))).foregroundColor(.red)
//            }
//        }
