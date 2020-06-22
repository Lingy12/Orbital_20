//
//  StudyView.swift
//  Orbital_20
//
//  Created by 张远星 on 18/6/20.
//  Copyright © 2020 zhangyuanxing. All rights reserved.
//

import SwiftUI

struct StudyView: View {
    
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
                    
                    // TODO: set the time according to user's choice
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
                    // TODO: countdown time
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



struct StudyView_Previews: PreviewProvider {
    static var previews: some View {
        StudyView()
    }
}