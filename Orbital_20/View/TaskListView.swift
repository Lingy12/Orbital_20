//
//  TaskListView.swift
//  Orbital_20
//
//  Created by 张远星 on 18/6/20.
//  Copyright © 2020 zhangyuanxing. All rights reserved.
//

import SwiftUI

struct TaskListView: View {
    @State private var newTask = ""
    
    var body: some View {
        ZStack {
            
            //Navigation view
            NavigationView {
                List {
                    Section(header: Text ("Add new task")) {
                        HStack {
                            TextField("Task Name", text: self.$newTask)
                            Button(action: {
                                // TODO:type in task and bing to newTask
                                // newTask = ...
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.green)
                                    .imageScale(.large)
                            }
                        }
                    }.font(.headline)
                    
                    Section(header: Text("Tasks")) {
                        TaskView(title: "Orbital", deadline: "tomorrow")
                    }
                }
                .navigationBarTitle(Text("My Task List"))
                .navigationBarItems(trailing: EditButton())
            }
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}
