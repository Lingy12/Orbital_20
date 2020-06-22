//
//  Manage.swift
//  Orbital_20
//
//  Created by Jerry Lin on 1/6/20.
//  Copyright © 2020 Jerry Lin. All rights reserved.


//Class Manage is used to manage the activity of the application

import SwiftUI
import Foundation

class Manage:ObservableObject {
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: Task.entity(), sortDescriptors: []) var assignmentList:FetchedResults<Task>
    
    //MARK: -Basic functionality
    func addTask(due date:Date,_ name:String,at plan:Date,_ time:Int16) {
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
    
    
    func setPlan(for task:Task,to date:Date) {
        self.objectWillChange.send()
        context.perform {
            task.planDate = date
             try? self.context.save()
        }
    }
    
    func setTimer(for task:Task, _ time: Int16) {
        self.objectWillChange.send()
        context.perform {
            task.planTime = time
            try? self.context.save()
        }
    }
    
    func clearAll() {
        self.objectWillChange.send()
        
        context.perform {
            for index in self.assignmentList.indices {
                self.context.delete(self.assignmentList[index])
            }
            try? self.context.save()
        }
        
    }
    
    func delete(_ task:Task) {
        self.objectWillChange.send()
        let chosenIndex = assignmentList.firstIndex(of: task)!
        
        context.perform {
            self.context.delete(self.assignmentList[chosenIndex])
            try? self.context.save()
        }
    }
    
    func extends(_ task: Task,for time:Int16) {
        self.objectWillChange.send()
       
        context.perform {
            task.extendCount += 1
            task.planTime += time
            try? self.context.save()
        }
        
    }
    
    //MARK: - Transformation for time representation
    func clockRepresent(_ miniute:Int16) -> (Int16,Int16){
        return (miniute/60, miniute%60)
    }
    
    func minuteRepresent(_ clock:(Int16,Int16)) -> Int16 {
        return clock.0 * 60 + clock.1
    }
    
}
