//
//  SingleTaskView.swift
//  Orbital_20
//
//  Created by 张远星 on 18/6/20.
//  Copyright © 2020 zhangyuanxing. All rights reserved.
//

import SwiftUI

struct SingleTaskView: View {
    var title: String = ""
    var deadline: String = ""
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title).font(.headline)
                Text(deadline).font(.caption)
            }
        }
        
    }
}

struct SingleTaskView_Previews: PreviewProvider {
    static var previews: some View {
        SingleTaskView(title: "Orbital", deadline: "tomorrow")
    }
}
