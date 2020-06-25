//
//  ModuleTaskView.swift
//  Orbital_20
//
//  Created by Jerry Lin on 24/6/20.
//  Copyright © 2020 Jerry Lin. All rights reserved.
//

import SwiftUI

struct ModuleTaskView: View {
    var module:String
    @FetchRequest(entity: Task.entity(), sortDescriptors: []) var taskList:FetchedResults<Task>
    @State var showTaskCreation = false
    
    var body: some View {
        VStack {
            if !showTaskCreation {
                Section(header:Text(module)){
                    
                    List{
                        ForEach(self.getModuleAssignmentList(),id: \.self) { task in
                            SingleTaskView(task: task)
                        }
                    }
                }
            } else {
                ModuleTaskCreationView(showCreation: self.$showTaskCreation, module: module)
            }
        }
    }
    
    private func getModuleAssignmentList() -> [Task] {
        var assignmentList:[Task] = []
        
        for index in self.taskList.indices {
            if self.taskList[index].modName == self.module {
                assignmentList.append(self.taskList[index])
            }
        }
        
        return assignmentList
    }
}

