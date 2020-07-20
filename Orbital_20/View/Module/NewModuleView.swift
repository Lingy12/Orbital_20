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
        
        VStack {
            
            backButton.frame(alignment:.leading)
            
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
            }.sheet(isPresented: self.$showTaskCreation) {
                NewTaskView(showCreation: self.$showTaskCreation,module:self.moduleName)
                    .environment(\.managedObjectContext, self.context)
            }
            
        }
    }
    
    private func addModule(for modname:String) {
        if self.haveMod(modname: modname) {
            let newModule = Module(context: context)
            newModule.moduleName = modname
            try? self.context.save()
        }
    }
    
    private var backButton:some View {
        HStack {
            Button(action: {
                self.showModcreation.toggle()
            }, label: {
                Image(systemName: "delete.left")
                    .imageScale(.medium)
            }).frame(alignment:.leading)
        }
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
    
    private func haveMod(modname:String) -> Bool {
        return self.moduleList.contains(where:{ element in
            element.moduleName! == modname
        } )
    }
}
