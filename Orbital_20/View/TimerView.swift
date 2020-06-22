//
//  TimerView.swift
//  Orbital_20
//
//  Created by Jerry Lin on 22/6/20.
//  Copyright © 2020 Jerry Lin. All rights reserved.
//

import SwiftUI

struct TimerView: View {
    @State var timeRemaining:Int16
       let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

       var body: some View {
           Text("\(timeRemaining)")
               .onReceive(timer) { _ in
                   if self.timeRemaining > 0 {
                       self.timeRemaining -= 1
                   }
               }
       }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(timeRemaining:60)
    }
}
