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
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: Task.entity(), sortDescriptors: []) var assignmentList:FetchedResults<Task>

    
    var body: some View {
        Form {
            TextField("New Task Name", text: $TaskName)
            DatePicker("Due", selection: $dueDate)
            TextField("Time to complete",text: $completeTime).keyboardType(.numberPad)
            DatePicker("Plan Date",selection: $planDate)
            
            Section {
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(.blue)
                    
                    Button(action: {
                        self.addTask(due: self.dueDate, self.TaskName, at: self.planDate, Int16(self.completeTime) ?? 0)
                        self.showCreation.toggle()
                    }) {
                        Text("save")
                    }
                }
            }
        }
    }
    
    private func addTask(due date:Date,_ name:String,at plan:Date,_ time:Int16) {
           let newAssignment = Task(context: context)
           newAssignment.isComplete = false
           newAssignment.hasStarted = false
           newAssignment.planTime = time
           newAssignment.due = date
           newAssignment.name = name
           newAssignment.planDate = plan
           newAssignment.extendCount = 0
           try? self.context.save()
       }
}

struct NewTaskView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
