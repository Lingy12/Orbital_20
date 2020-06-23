//
//  SingleModuleView.swift
//  Orbital_20
//
//  Created by 张远星 on 23/6/20.
//  Copyright © 2020 Jerry Lin. All rights reserved.
//

import SwiftUI

struct SingleModuleView: View {
    var module: Module
    var body: some View {
        HStack {
            Text(module.moduleName!)
            Spacer()
        }
    }
}

struct SingleModuleView_Previews: PreviewProvider {
    static var previews: some View {
        SingleModuleView(module: Module)
    }
}
