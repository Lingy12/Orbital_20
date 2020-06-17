//
//  ContentView.swift
//  Orbital_20
//
//  Created by Jerry Lin on 18/5/20.
//  Copyright © 2020 Jerry Lin. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var date = Date()
    
    var body: some View {
        ZStack {
            
            //background
            Rectangle()
                .foregroundColor(Color.black)
                .edgesIgnoringSafeArea(.all)
            
            Rectangle()
                .foregroundColor(Color.white)
                .rotationEffect(Angle(degrees: 45))
                .edgesIgnoringSafeArea(.vertical)
            
            //elements of interfaces
            VStack {
                
                Spacer()
                
                //End time
                HStack {
                    Image(systemName: "star.fill").foregroundColor(.yellow)
                    
                    Text("End at: 17:00").bold().foregroundColor(.blue)
                                        
                    Image(systemName: "star.fill").foregroundColor(.yellow)
                }.scaleEffect(2)
                
                Spacer()
                
                //ClockView
                Text("\(timeString(date: date))").bold().scaleEffect(2)
                .onAppear(perform: {let _ = self.updateTimer})
                
                Spacer()
                
                //Timer
                VStack {
                    Text("Time Remaining:").bold().foregroundColor(.red)
                    Text("0:05:30").bold().foregroundColor(.red)
                }.scaleEffect(1.75)
                
                Spacer()
                
                //Button
                Button(action: {
                    //change bottom appearance and stop timer
                    
                }, label:
                    {
                        Text("Pause").bold()
                            .foregroundColor(.white)
                            .padding(.all, 10)
                            .padding([.leading, .trailing], 30)
                            .background(Color.pink)
                        .cornerRadius(20)
                })
                
                Spacer()
            }
        }
    }
    
    var timeFormat: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm:ss a"
        return formatter
    }

    func timeString(date: Date) -> String {
        let time = timeFormat.string(from: date)
         return time
    }

    var updateTimer: Timer {
         Timer.scheduledTimer(withTimeInterval: 1, repeats: true,
                              block: {_ in
                                 self.date = Date()
                               })
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
