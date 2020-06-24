//
//  NewTaskView.swift
//  Orbital_20
//
//  Created by Jerry Lin on 23/6/20.
//  Copyright © 2020 Jerry Lin. All rights reserved.
//

import SwiftUI

struct NewTaskView: View {
    @Binding var showCreation: Bool
    @State var TaskName = ""
    @State var dueDate = Date()
    @State var completeTime = ""
    @State var planDate = Date()
    @State var moduleName = ""
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: Task.entity(), sortDescriptors: []) var assignmentList:FetchedResults<Task>
    @FetchRequest(entity: Module.entity(), sortDescriptors: []) var moduleList:FetchedResults<Module>
    
    var body: some View {
        Form {
            TextField(self.moduleName == "" ? "Module Name":self.moduleName,text: $moduleName)
            TextField("New Task Name", text: $TaskName)
            DatePicker("Due", selection: $dueDate)
            TextField("Time to complete",text: $completeTime).keyboardType(.numberPad)
            DatePicker("Plan Date",selection: $planDate)
            
            
            Section {
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(.blue)
                    
                    Button(action: {
                        self.addTask(due: self.dueDate, self.TaskName, at: self.planDate, Int16(self.completeTime) ?? 0,for:self.moduleName)
                        self.showCreation.toggle()
                        
                    }) {
                        Text("save")
                            .foregroundColor(.red)
                    }
                }
            }
        }
    }
    
    private func updateModule(task:Task) {
        for index in moduleList.indices {
            if moduleList[index].moduleName == self.moduleName {
                moduleList[index].assignmentList?.append(task)
                return
            }
        }
        let newModule = Module(context: context)
        var assignmentList:[Task] = []
        newModule.moduleName = self.moduleName
        assignmentList.append(task)
        newModule.assignmentList = assignmentList
        try? self.context.save()
    }
    
    private func addTask(due date:Date,_ name:String,at plan:Date,_ time:Int16,for module:String) {
        let newAssignment = Task(context: context)
        newAssignment.due = date
        newAssignment.name = name
        newAssignment.planDate = plan
       
        newAssignment.modName = module
        self.updateModule(task: newAssignment)
        try? self.context.save()
    }
}

struct NewTaskView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
