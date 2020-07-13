//
//  ModuleTaskView.swift
//  Orbital_20
//
//  Created by Jerry Lin on 24/6/20.
//  Copyright © 2020 Jerry Lin. All rights reserved.
// Display added module in creation process

import SwiftUI

struct AddedTaskView: View {
    var moduleName:String
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Task.due, ascending: true)]) var assignmentList:FetchedResults<Task>
    @State var mutiselectMode = false
    var body: some View {
        List {
            ForEach(self.getModuleAssignmentList(),id: \.self){ task in
                SingleTaskView(task: task,mutiselectMode: self.$mutiselectMode)//,isComplete: task.isComplete)
            }
        }
    }
    
    
    private func getModuleAssignmentList() -> [Task] {
        var assignmentList:[Task] = []
        
        for index in self.assignmentList.indices {
            if self.assignmentList[index].modName == self.moduleName {
                assignmentList.append(self.assignmentList[index])
            }
        }
        
        return assignmentList
    }
}

