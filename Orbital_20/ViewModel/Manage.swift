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
    @FetchRequest(entity: Assignment.entity(), sortDescriptors: []) var assignmentList:FetchedResults<Assignment>
    
    //MARK: -Basic functionality
    func addAssignment(due date:Date,_ name:String,at plan:Date,for time:Int16) {
        let newAssignment = Assignment(context: context)
        newAssignment.isComplete = false
        newAssignment.hasStarted = false
        newAssignment.planTime = time
        newAssignment.name = name
        newAssignment.planDate = plan
        newAssignment.remainingTime = time
        try? self.context.save()
    }
    
    func setPlan(for assignment:Assignment,to date:Date) {
        self.objectWillChange.send()
        context.perform {
            assignment.planDate = date
             try? self.context.save()
        }
    }
    
    func setTimer(for assignment:Assignment, _ time: Int16) {
        self.objectWillChange.send()
        context.perform {
            assignment.planTime = time
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
    
    func delete(_ assignment:Assignment) {
        self.objectWillChange.send()
        let chosenIndex = assignmentList.firstIndex(of: assignment)!
        
        context.perform {
            self.context.delete(self.assignmentList[chosenIndex])
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
