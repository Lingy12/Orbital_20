//
//  NewModuleView.swift
//  Orbital_20
//
//  Created by Jerry Lin on 24/6/20.
//  Copyright © 2020 Jerry Lin. All rights reserved.
//  Adding new module to the application, can create new module associate with creating new task

import SwiftUI

struct NewModuleView: View {
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: Module.entity(), sortDescriptors: []) var moduleList:FetchedResults<Module>
    @FetchRequest(entity: Task.entity(), sortDescriptors: []) var taskList:FetchedResults<Task>
    
    @Binding var showModcreation:Bool
    @State var moduleName = ""
    @State var showTaskCreation = false
    
    
    var body: some View {
        
        ZStack {
            if !self.showTaskCreation {
                HStack {
                    Button(action:{
                        self.showTaskCreation.toggle()
                    }) {
                        Text("<back")
                            .foregroundColor(.blue)
                            .frame(alignment:.leading)
                    }.frame(alignment:.leading)
                        .padding()
                    Spacer()
                }
                Form {
                    Section(header:Text("Add new module")) {
                        TextField("New Module Name",text: $moduleName)
                    }
                    Section(header: Text ("Add new task for \(moduleName)")) {
                        HStack {
                            Button(action: {
                                self.showTaskCreation.toggle()
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.green)
                                    .imageScale(.large)
                            }
                        }
                    }.font(.headline)
                    
                    Section(header:Text("Added Task")) {
                        AddedTaskView(moduleName: moduleName)
                    }
                    
                    Section {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundColor(.blue)
                            
                            Button(action: {
                                self.showModcreation.toggle()
                            }) {
                                Text("Save")
                                    .foregroundColor(.black)
                            }
                            
                        }
                    }
                }
            } else {
                NewTaskView(showCreation: self.$showTaskCreation,module:self.moduleName)
            }
        }
        
    }
    
    private func addModule(for modname:String) {
        let newModule = Module(context: context)
        newModule.moduleName = modname
        try? self.context.save()
    }
    
    private func getModuleAssignmentList() -> [Task] {
        var assignmentList:[Task] = []
        
        for index in self.taskList.indices {
            if self.taskList[index].modName == self.moduleName {
                assignmentList.append(self.taskList[index])
            }
        }
        
        return assignmentList
    }
}
