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
    @State var mutiSelectMode = false
    @State var selection:[Task]?
    var module:String?
    
    
    var body: some View {
        VStack {
            //Navigation view
            Button(action:{
                for index in self.assignmentList.indices {
                    self.context.delete(self.assignmentList[index])
                }
                for index in self.moduleList.indices {
                    self.context.delete(self.moduleList[index])
                }
                try? self.context.save()
            }) {
                Text("Reset")
            }
            if module == nil {
                NavigationView {
                    if mutiSelectMode {
                        taskList.navigationBarItems(leading:doneButton,trailing: deleteButton)
                    } else {
                        taskList.navigationBarItems(leading:editButton,trailing: addButton)
                    }
                }
            } else {
                if mutiSelectMode {
                    taskList.navigationBarItems(leading:doneButton,trailing: deleteButton)
                } else {
                    taskList.navigationBarItems(leading:editButton,trailing: addButton)
                }
            }
        }.sheet(isPresented: self.$showCreation) {
            NewTaskView(showCreation: self.$showCreation,module: self.module)
                .environment(\.managedObjectContext, self.context)
        }
    }
    
    
    private var addButton: some View {
        Button(action: {
            self.showCreation.toggle()
        }) {
            Image(systemName: "plus.circle.fill")
                .foregroundColor(.green)
                .imageScale(.large)
        }
    }
    
    private var editButton:some View {
        Button(action:{
            self.mutiSelectMode = true
            self.selection = [] //initialize the optional, so that it's safe to unwrap directly
        }) {
            Image(systemName: "square.and.pencil")
                .foregroundColor(.blue)
                .imageScale(.large)
        }
    }
    
    private var doneButton: some View {
        Button(action:{
            self.mutiSelectMode = false
            self.selection = nil // Release all the selection
        }) {
            Text("Done").foregroundColor(.blue)
        }
    }
    private var deleteButton : some View {
        Button(action: {
            self.deleteSet(set: self.selection)
            self.mutiSelectMode = false//toggle the mutiselect mod after deletion
        }) {
            Text("Delete").foregroundColor(.blue)
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
    
    private func deleteTask(task:Task) {
        let index = assignmentList.firstIndex(of: task)!
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
        
        try? self.context.save()
    }
    
    //TODO:Handle optional
    private func deleteSet(set:[Task]?) {
        for index in set!.indices {
            deleteTask(task: set![index])
        }
    }
    
    private func getModuleAssignmentList() -> [Task] {
        var assignmentList:[Task] = []
        
        
        for index in self.assignmentList.indices {
            if self.assignmentList[index].modName == self.module ??  ""  || module == nil{
                assignmentList.append(self.assignmentList[index])
            }
        }
        
        return assignmentList
    }
    
    private var taskList: some View {
        VStack {
            List {
                Section(header: Text("Tasks")) {
                    ForEach(self.getModuleAssignmentList(),id:\.self) {assignment in
                        ZStack {
                            if self.mutiSelectMode {
                                SingleTaskView(task: assignment,isselected:self.selection!.contains(assignment), mutiselectMode: self.$mutiSelectMode)
                                .onTapGesture(perform: {
                                    self.selection?.append(assignment)
                                })
                            } else {
                                NavigationLink(destination:StudyView(task: assignment)) {
                                    SingleTaskView(task: assignment,mutiselectMode:self.$mutiSelectMode)//,isComplete: assignment.isComplete)
                                }
                            }
                        }
                    }.onDelete(perform: deleteTask)
                }
                
            }
            .navigationBarTitle(module ?? "My Task List")
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}

