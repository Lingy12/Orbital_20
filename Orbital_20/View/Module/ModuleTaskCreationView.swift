//
//  ModuleTaskCreationView.swift
//  Orbital_20
//
//  Created by Jerry Lin on 24/6/20.
//  Copyright © 2020 Jerry Lin. All rights reserved.
//

import SwiftUI

struct ModuleTaskCreationView: View {
    @Binding var showCreation:Bool
    
    @Environment(\.managedObjectContext) var context
    var module:String
    @State var TaskName = ""
    @State var dueDate = Date()
    @State var planHour = 0
    @State var planMinutes = 0
    @State var planDate = Date()
    @FetchRequest(entity: Task.entity(), sortDescriptors: []) var assignmentList:FetchedResults<Task>
    @FetchRequest(entity: Module.entity(), sortDescriptors: []) var moduleList:FetchedResults<Module>
    
    var body: some View {
        Form {
            
            Section(header: Text("Creating task for \(module)")) {
                TextField("New Task Name", text: $TaskName)
                DatePicker("Due", selection: $dueDate)
                VStack {
                    Text("Pick your time for this assignment")
                    
                    HStack {
                        Picker(selection: $planHour,label: Text("hours")) {
                            ForEach(0..<23) {
                                Text("\($0) h")
                            }
                        }
                        
                        Picker(selection: $planMinutes,label:Text("mins")) {
                            ForEach(0..<59) {
                                Text("\($0) min")
                            }
                        }
                    }
                }
                DatePicker("Plan Date",selection: $planDate)
            }
            
            Section {
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(.blue)
                    
                    Button(action: {
                        self.addTask(due: self.dueDate, self.TaskName, at: self.planDate, Int16(self.planHour*60 + self.planMinutes),for:self.module)
                        self.showCreation.toggle()
                        
                    }) {
                        Text("Save")
                            .foregroundColor(.red)
                    }
                }
            }
            
        }
    }
    
    private func addTask(due date:Date,_ name:String,at plan:Date,_ time:Int16,for module:String) {
        let newAssignment = Task(context: context)
        newAssignment.due = date
        newAssignment.name = name
        newAssignment.planDate = plan
        if !self.haveMod(modname: module) {
            let newMod = Module(context: context)
            newMod.moduleName = module
        }
        newAssignment.modName = module
        try? self.context.save()
    }
    
    private func haveMod(modname:String) -> Bool {
        for index in self.moduleList.indices {
            if moduleList[index].moduleName == modname {
                return true
            }
        }
        return false
    }
}

