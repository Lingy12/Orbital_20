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
    
    var body: some View {
        List {
            ForEach(modList,id:\.self) { mod in
                SingleStatView(module: mod)
            }
        }
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
    }
}
