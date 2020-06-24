//
//  ContentView.swift
//  Orbital_20
//
//  Created by 张远星 on 18/6/20.
//  Copyright © 2020 Jerry Lin. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: ModuleListView()) {
                    Text("Go to module list")
                        .font(.title)
                        .foregroundColor(Color(hue: 1.0, saturation: 0.62, brightness: 0.301))
                        .frame(alignment: .center)
                    
                }.padding()
                    .foregroundColor(.blue)
                
            }
            NavigationLink(destination:TaskListView()) {
                Text("Go to task list")
                    .font(.title)
                    .foregroundColor(Color(hue: 1.0, saturation: 0.62, brightness: 0.301))
                    .frame( alignment: .center)
                
            }
            .padding()
            .foregroundColor(.blue)
            
        }
    }
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
