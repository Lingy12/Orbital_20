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
    @FetchRequest(entity: Task.entity(), sortDescriptors: []) var assignmentList:FetchedResults<Task>
    
    var body: some View {
        List {
            ForEach(self.getModuleAssignmentList(),id: \.self){ task in
                SingleTaskView(task: task)
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

