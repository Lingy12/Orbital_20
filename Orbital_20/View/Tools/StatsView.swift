//
//  StatsView.swift
//  Orbital_20
//
//  Created by Jerry Lin on 30/6/20.
//  Copyright © 2020 Jerry Lin. All rights reserved.
//

import SwiftUI

struct StatsView: View {
    @FetchRequest(entity: Module.entity(), sortDescriptors: []) var modList:FetchedResults<Module>
    @State var showPie:Bool = false
    var body: some View {
        VStack {
            
            HStack {
                Spacer()
                Button(action: {
                    self.showPie.toggle()
                }, label: {
                    Text(self.showPie ? "List View" : "Pie chart")
                })
            }.padding()
            
            if showPie {
                Piechart()
            } else {
                List {
                    ForEach(modList,id:\.self) { mod in
                        SingleStatView(module: mod)
                    }
                }
            }
        }
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
    }
}
