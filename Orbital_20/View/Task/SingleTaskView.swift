//
//  SingleTaskView.swift
//  Orbital_20
//
//  Created by 张远星 on 18/6/20.
//  Copyright © 2020 zhangyuanxing. All rights reserved.
//

import SwiftUI

struct SingleTaskView: View {
    
    var task:Task
    @State var isComplete:Bool
    
    var body: some View {
        Toggle(isOn: self.$isComplete) {
            HStack {
                VStack{
                    Text(task.name!).font(.headline)
                    Text(dateToTime(date: task.due!)).font(.caption)
                }

                Spacer()

                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundColor(.blue)

                Text(task.modName!).font(.body).opacity(0.7)
            }
        }.toggleStyle(CheckboxStyle())
      
//        HStack {
//            VStack {
//                Text(task.name!).font(.headline)
//                Text(dateToTime(date: task.due!)).font(.caption)
//            }
//
//            Spacer()
//
//            Text(task.modName!).font(.body).opacity(0.7)
//        }
    }
    
    func dateToTime(date:Date) -> String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        let time = df.string(from: date)
        return time
    }
}


