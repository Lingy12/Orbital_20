//
//  ModuleListView.swift
//  Orbital_20
//
//  Created by 张远星 on 23/6/20.
//  Copyright © 2020 Jerry Lin. All rights reserved.
//


import SwiftUI

struct ModuleListView: View {
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: Module.entity(), sortDescriptors: []) var moduleList:FetchedResults<Module>
    @FetchRequest(entity: Task.entity(), sortDescriptors: []) var taskList:FetchedResults<Task>
    
    @State var showModCreation = false
    
    var body: some View {
        VStack {
            if showModCreation {
                NewModuleView(showModcreation: $showModCreation)
            } else {
                NavigationView {
                    List {
                        Section(header: Text ("Add new module")) {
                            HStack {
                                Button(action: {
                                    self.showModCreation.toggle()
                                }) {
                                    Image(systemName: "plus.circle.fill")
                                        .foregroundColor(.green)
                                        .imageScale(.large)
                                }
                            }
                        }.font(.headline)
                        
                        Section(header: Text("My Modules")) {
                            ForEach(moduleList,id: \.self) { module in
                                ZStack {
                                    if self.countTask(name: module.moduleName!) > 0 {
                                        NavigationLink(destination: ModuleTaskView(module:module.moduleName!)) {
                                            
                                            SingleModuleView(module: module)
                                        }
                                    }
                                    
                                }
                                
                            }.onDelete(perform: deleteModule)
                        }
                        
                    }
                .navigationBarTitle(Text("Modules"))
                }
            }
        }
    }
    
    private func deleteModule(indexSet:IndexSet) {
        for index in indexSet {
            let itemToDelete = moduleList[index]
            context.delete(itemToDelete)
            self.deleteAssociateTask(module: itemToDelete)
        }
        
        try? self.context.save()
    }
    
    private func deleteAssociateTask(module:Module) {
        for index in self.taskList.indices {
            if self.taskList[index].modName == module.moduleName {
                context.delete(self.taskList[index])
            }
        }
        try?self.context.save()
    }
    
    private func countTask(name:String) -> Int{
        var count = 0
        for index in self.taskList.indices {
            if self.taskList[index].modName == name {
                count += 1
            }
        }
        return count
    }
}

struct ModuleListView_Previews: PreviewProvider {
    static var previews: some View {
        ModuleListView()
    }
}
