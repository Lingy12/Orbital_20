//
//  TimerView.swift
//  Orbital_20
//
//  Created by Jerry Lin on 23/6/20.
//  Copyright © 2020 Jerry Lin. All rights reserved.
//

import SwiftUI

struct TimerView: View {
    @ObservedObject var timerManager = TimerManager()
    @State var selectedPickerIndex = 0
    
    let availableMinutes = Array(1...59)
    
    var body: some View {
        
        
        VStack {
            //- MARK: COUNTDOWN
            VStack {
                Text("Time Remaining:").bold().foregroundColor(.red)
                // TODO: countdown time
                Text(secondsToMinSec(seconds: timerManager.secondsLeft)).bold().foregroundColor(.red)
            }.scaleEffect(1.75)
            
            Spacer()
            
            //PauseButton
            Text(timerManager.timerMode == .running ? "Pause" : "Continue").bold()
                    .foregroundColor(.white)
                    .padding(.all, 10)
                    .padding([.leading, .trailing], 30)
                    .background(Color.pink)
                    .cornerRadius(20)
                    .onTapGesture(perform: {
                        if (self.timerManager.timerMode == .initial) {
                            self.timerManager.setTimerLength(minutes: self.availableMinutes[self.selectedPickerIndex * 60])
                        }
                        self.timerManager.timerMode == .running
                        ? self.timerManager.pause()
                        : self.timerManager.start()
                    })
            
            if timerManager.timerMode == .paused {
                Image(systemName: "gobackward")
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .padding(.top, 40)
                    .onTapGesture(perform: {
                        self.timerManager.reset()
                    })
            }
            
            if timerManager.timerMode == .initial {
                Picker(selection: $selectedPickerIndex, label: Text("")) {
                    ForEach (0 ..< availableMinutes.count) {
                        Text("\(self.availableMinutes[$0]) min")
                    }
                }.labelsHidden()
            }
            
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
