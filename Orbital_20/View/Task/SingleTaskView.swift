//
//  SingleTaskView.swift
//  Orbital_20
//
//  Created by 张远星 on 18/6/20.
//  Copyright © 2020 zhangyuanxing. All rights reserved.
//

import SwiftUI

struct SingleTaskView: View {
    
    @ObservedObject var task:Task
    // @State var isComplete:Bool
    var isselected:Bool = false
    
    var body: some View {
        ZStack {
            if isselected {
                singleTask
            } else {
                Toggle(isOn: self.$task.isComplete) {
                    singleTask
                }.toggleStyle(CheckboxStyle())
            }
        }
    }
    
    var singleTask: some View {
        HStack {
            VStack{
                Text(task.name ?? "").font(.headline)
                Text(dateToTime(date: task.due ?? Date())).font(.caption)
            }
            
            Spacer()
            
            if isselected {
                Image(systemName: "checkmark")
                    .foregroundColor(.black)
            } else {
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundColor(.blue)
                
                Text(task.modName ?? "").font(.body).opacity(0.7)
            }
            
        }.foregroundColor(isselected ? .gray : .clear)
    }
    
    func dateToTime(date:Date) -> String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        let time = df.string(from: date)
        return time
    }
}


