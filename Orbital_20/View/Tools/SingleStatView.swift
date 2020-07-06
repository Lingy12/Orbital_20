//
//  SingleStatView.swift
//  Orbital_20
//
//  Created by Jerry Lin on 2/7/20.
//  Copyright © 2020 Jerry Lin. All rights reserved.
//

import SwiftUI

struct SingleStatView: View {
    @ObservedObject var module:Module
    
    var body: some View {
        HStack {
            Text(module.moduleName ?? "")
            Spacer()
            Text(intervalFormatter(interval: self.module.spentTime))
        }
    }
    
    //TODO: Better Representation of the stats
    func intervalFormatter(interval:Double) -> String {
        return String(format: "%.2f h", module.spentTime / 3600)
    }
}

