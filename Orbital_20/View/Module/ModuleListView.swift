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
    
    @State var showModCreation = false
    
    var body: some View {
        ZStack {
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
                            List {
                                ForEach(moduleList,id: \.self) { module in
                                    NavigationLink(destination: ModuleTaskView(module:module)) {
                                        SingleModuleView(module: module)
                                    }
                                }
                            }
                        }
                        
                    }
                    .navigationBarTitle(Text("Modules"))
                    .navigationBarItems(trailing: EditButton())
                }
            }
        }
    }
}

struct ModuleListView_Previews: PreviewProvider {
    static var previews: some View {
        ModuleListView()
    }
}
