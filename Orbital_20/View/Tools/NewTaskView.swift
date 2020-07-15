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
    //    @State var planHour = 0
    //    @State var planMinutes = 0
    @State var planTime = ""
    @State var planDate = Date()
    @State var moduleName = ""
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Task.due, ascending: true)]) var assignmentList:FetchedResults<Task>
    @FetchRequest(entity: Module.entity(), sortDescriptors: []) var moduleList:FetchedResults<Module>
    var module:String?
    @State var showAlert = false
    
    var body: some View {
        
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    self.showCreation.toggle()
                },label: {
                    Image(systemName: "chevron.down.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(.blue)
                        .opacity(0.8)
                }).padding(.trailing, 20)
                    .padding(.top,15)
                    .shadow(radius: 5)
            }
            
            //            padding(15)
            
            Form {
                Section(header:Text(module == nil ? "Creating New Task" : "Creating new Task for \(module!)")) {
                    if module == nil {
                        TextField("Module Name",text: $moduleName)
                    }
                    TextField("New Task Name", text: $TaskName)
                    DatePicker("Due", selection: $dueDate,in:Date()...)
                    VStack {
                        Text("Pick your time for this assignment")
                        
                        //                TimePicker(planHour:self.$planHour,planMinutes:self.$planMinutes)
                        TextField("Minutes",text: $planTime).keyboardType(.numberPad)
                    }
                    
                    DatePicker("Plan Date",selection: $planDate,in: Date()...)
                }
                
                Section {
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(.blue)
                        
                        Button(action: {
                            if (self.TaskName == "" || self.moduleName == "") {
                                self.showAlert = true
                            } else {
                                self.addTask(due: self.dueDate, self.TaskName, at: self.planDate, Int16(self.planTime) ?? 0,for:self.moduleName)
                                self.showCreation.toggle()
                            }
                        }) {
                            Text("save")
                                .foregroundColor(.black)
                        }.alert(isPresented: $showAlert) {
                            Alert(title: Text("Input error"), message: Text("Some field is empty"), dismissButton: .default(Text("Got it"), action: {
                                self.showAlert = false
                            }))
                        }
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
        newAssignment.isComplete = false
        newAssignment.duration = time
        newAssignment.extendCount = 0
        if !self.haveMod(modname: module) {
            let newMod = Module(context: context)
            newMod.moduleName = module
            try? self.context.save()
        }
        newAssignment.modName = module
        
        
        
        try? self.context.save()
        
        //notification for due
        var daycomponent = DateComponents()
        daycomponent.day = -1
        let content = UNMutableNotificationContent()
        
        //set up the content
        content.title = "\(module)"
        content.body = "\(name) due in one day"
        
        //schedule the content to calendar
        let calendar = Calendar.current
        let nextTriggerDay = calendar.date(byAdding: daycomponent, to: date)!
        let triggerComp = Calendar.current.dateComponents([.year,.month,.day], from: nextTriggerDay)
        
        //create trigger
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerComp, repeats: false)
        //create request
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        //create the nonification
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request, withCompletionHandler: nil)
        print("scheduled")
        
        //notification for plan
        let content1 = UNMutableNotificationContent()
        content1.title = "\(module)"
        content1.body = "Time to start \(name)"
        let triggerComp1 = Calendar.current.dateComponents([.year,.month,.day], from: plan)
        let trigger1 = UNCalendarNotificationTrigger(dateMatching: triggerComp1, repeats: false)
        let id = UUID().uuidString
        let request1 = UNNotificationRequest(identifier: id, content: content, trigger: trigger1)
        notificationCenter.add(request1, withCompletionHandler: nil)
    }
    
    private func haveMod(modname:String) -> Bool {
        return self.moduleList.contains(where:{ element in
            element.moduleName! == moduleName
        } )
    }
}
