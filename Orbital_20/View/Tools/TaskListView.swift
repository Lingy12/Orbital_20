//
//  TaskListView.swift
//  Orbital_20
//
//  Created by 张远星 on 18/6/20.
//  Copyright © 2020 zhangyuanxing. All rights reserved.
//

import SwiftUI

struct TaskListView: View {
    
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Task.due, ascending: true)]) var assignmentList:FetchedResults<Task>
    @FetchRequest(entity: Module.entity(), sortDescriptors: []) var moduleList:FetchedResults<Module>
    @State var showCreation = false
    @State var showStudy = false
    var module:String?
    
    
    var body: some View {
        VStack {
            //Navigation view
            if !self.showCreation {
                if module == nil {
                    NavigationView {
                        taskList.navigationBarTitle(Text("My Task List"))
                    }
                } else {
                    taskList.navigationBarTitle(Text(module!))
                }
            } else {
                if module != nil {
                    NewTaskView(showCreation: self.$showCreation, module: module)
                } else {
                    NewTaskView(showCreation: self.$showCreation)
                }
            }
        }
    }
    
    private func deleteTask(indexSet:IndexSet) {
        for index in indexSet {
            let itemToDelete = assignmentList[index]
            let name = itemToDelete.modName!
            context.delete(itemToDelete)
            try? self.context.save()
            let count = self.countTask(name:name)
            
            if count == 0 {
                for x in self.moduleList.indices {
                    if self.moduleList[x].moduleName == name {
                        context.delete(self.moduleList[x])
                    }
                }
            }
        }
        
        try? self.context.save()
    }
    
    private func countTask(name:String) -> Int{
        var count = 0
        for index in self.assignmentList.indices {
            if self.assignmentList[index].modName == name {
                count += 1
            }
        }
        return count
    }
    
    private func getModuleAssignmentList() -> [Task] {
        var assignmentList:[Task] = []
        
        for index in self.assignmentList.indices {
            if self.assignmentList[index].modName == self.module ??  "" {
                assignmentList.append(self.assignmentList[index])
            }
        }
        
        return assignmentList
    }
    
    private var taskList: some View {
        List {
            Section(header: Text ("Add new task")) {
                HStack {
                    Button(action: {
                        self.showCreation.toggle()
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.green)
                            .imageScale(.large)
                    }
                }
            }.font(.headline)
            
            
            
            Section(header: Text("Tasks")) {
                ForEach(self.assignmentList,id:\.self) {assignment in
                    ZStack {
                        NavigationLink(destination:StudyView(task: assignment)) {
                            SingleTaskView(task: assignment)//,isComplete: assignment.isComplete)
                        }
                    }
                }.onDelete(perform: deleteTask)
                
            }
            
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}

