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
        NavigationView {
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 0.5)
                        .foregroundColor(.blue)
                        .frame(width: 100, height: 75, alignment: .center)
                    NavigationLink(destination: ModuleListView()) {
                        Text("Go to module list")
                            .font(.body)
                            .foregroundColor(Color(hue: 1.0, saturation: 0.62, brightness: 0.301))
                             .frame(width:100,height:75,alignment: .center)
                        
                    }.padding()
                   
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 0.5)
                        .foregroundColor(.blue)
                        .frame(width:100,height: 75,alignment: .center)
                    NavigationLink(destination:TaskListView()) {
                        Text("Go to task list")
                            .font(.body)
                            .foregroundColor(Color(hue: 1.0, saturation: 0.62, brightness: 0.301))
                             .frame(width:100,height:75,alignment: .center)
                        
                    }
                    .padding()
                    
                    
                }
                Button(action:{
                    //Delete all data in core data
                    for index in self.assignmentList.indices {
                        self.context.delete(self.assignmentList[index])
                    }
                    
                    for index in self.moduleList.indices {
                        self.context.delete(self.moduleList[index])
                    }
                    
                    try? self.context.save()
                }) {
                    Text("RESET")
                        .font(.title)
                }
            }
        }
        
        
    }
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
