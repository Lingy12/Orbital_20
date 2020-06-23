//
//  ModuleListView.swift
//  Orbital_20
//
//  Created by 张远星 on 23/6/20.
//  Copyright © 2020 Jerry Lin. All rights reserved.
//


import SwiftUI

struct ModuleListView: View {
    
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text ("Add new module")) {
                    HStack {
                        Button(action: {
                            //TODO: add new module to moduledata
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.green)
                                .imageScale(.large)
                        }
                    }
                }.font(.headline)
                
                //TODO: Create module Data
                Section(header: Text("My Modules")) {
                    List(moduleData) { module in
                        NavigationLink(destination: TaskListView()) {
                            SingleModuleView(module: module)
                        }
                    }
                }
                
            }
            .navigationBarTitle(Text("Modules"))
            .navigationBarItems(trailing: EditButton())
        }
    }
}

struct ModuleListView_Previews: PreviewProvider {
    static var previews: some View {
        ModuleListView()
    }
}
