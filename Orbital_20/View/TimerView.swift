//
//  TimerView.swift
//  Orbital_20
//
//  Created by Jerry Lin on 23/6/20.
//  Copyright © 2020 Jerry Lin. All rights reserved.
//

import SwiftUI

struct TimerView: View {
    var body: some View {
        VStack {
            Text("Time Remaining:").bold().foregroundColor(.red)
            // TODO: countdown time
            Text("0:05:30").bold().foregroundColor(.red)
        }.scaleEffect(1.75)
        
        
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
