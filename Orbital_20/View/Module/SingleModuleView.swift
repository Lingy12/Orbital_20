//
//  SingleModuleView.swift
//  Orbital_20
//
//  Created by 张远星 on 23/6/20.
//  Copyright © 2020 Jerry Lin. All rights reserved.
//

import SwiftUI

struct SingleModuleView: View {
    @ObservedObject var module: Module
    var body: some View {
        HStack {
            Text(module.moduleName!)
            Spacer()
        }
    }
}
