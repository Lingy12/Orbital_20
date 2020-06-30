//
//  ContentView.swift
//  Orbital_20
//
//  Created by 张远星 on 18/6/20.
//  Copyright © 2020 Jerry Lin. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: Task.entity(), sortDescriptors: []) var assignmentList:FetchedResults<Task>
    @FetchRequest(entity: Module.entity(), sortDescriptors: []) var moduleList:FetchedResults<Module>
    
    var body: some View {
        TabView {
            TaskListView().tabItem() {
                VStack {
                    Image(systemName: "book.circle")
                        .resizable()
                    
                    Text("Tasks")
                }
            }
            
            ModuleListView().tabItem() {
                Image(systemName:"bolt.circle")
                    .resizable()
                Text("Modules")
            }
            
            StatsView().tabItem() {
                Image(systemName: "rosette")
                    .resizable()
                
                Text("Stats")
            }
        }
    }
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
