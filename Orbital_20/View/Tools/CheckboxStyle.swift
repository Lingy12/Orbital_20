//
//  CheckboxStyle.swift
//  Orbital_20
//
//  Created by Jerry Lin on 26/6/20.
//  Copyright © 2020 Jerry Lin. All rights reserved.
//

import SwiftUI

struct CheckboxStyle:ToggleStyle {
   
    func makeBody(configuration: Configuration) -> some View {
        return HStack {
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(configuration.isOn ? .purple : .gray)
                .font(.system(size:20,weight:.bold,design:.default))
                .onTapGesture {
                    configuration.isOn.toggle()
            }
            
            configuration.label
        }
    }
}
