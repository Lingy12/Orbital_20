//
//  TimePicker.swift
//  Orbital_20
//
//  Created by Jerry Lin on 26/6/20.
//  Copyright © 2020 Jerry Lin. All rights reserved.
//

import SwiftUI

struct TimePicker: View {
    var hours = Array(0...23)
    var minutes = Array(0...59)
    @Binding var planHour:Int
    @Binding var planMinutes:Int
    
    var body: some View {
        
        HStack {
            Picker(selection: $planHour,label: Text("hours")) {
                ForEach(0 ..< hours.count) {
                    Text("\(self.hours[$0]) h")
                }
            }
            
            Picker(selection: $planMinutes,label:Text("mins")) {
                ForEach(0 ..< minutes.count) {
                    Text("\(self.minutes[$0]) min")
                }
            }
        }
        
        
    }
}
