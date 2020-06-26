//
//  SimplestTimer.swift
//  Orbital_20
//
//  Created by Jerry Lin on 26/6/20.
//  Copyright © 2020 Jerry Lin. All rights reserved.
//

import SwiftUI

struct SimplestTimer: View {
    @State var timeRemaining:Int16
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(.black)
            
            Text(stringFormatter(seconds: timeRemaining * 60))
                .onReceive(timer) { _ in
                    if self.timeRemaining > 0 {
                        self.timeRemaining -= 1
                    }
            }.foregroundColor(.red)
        }
    }
    
    func stringFormatter(seconds:Int16) -> String {
        let hours = seconds / 3600
        let minites = (seconds - hours * 3600) / 60
        let sec = seconds - 3600 * hours - 60*minites
        
        return "\(hours):\(minites):\(sec)"
    }
}
