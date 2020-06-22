//
//  newTaskCreationView.swift
//  Orbital_20
//
//  Created by Jerry Lin on 22/6/20.
//  Copyright © 2020 Jerry Lin. All rights reserved.
//

import SwiftUI

struct newTaskCreationView: View {
    @State var showCreationView:Bool
    
    var body: some View {
        Text("Hello world")
        HStack {
            Button(action: <#T##() -> Void#>, label: <#T##() -> PrimitiveButtonStyleConfiguration.Label#>)
        }
    }
}

struct newTaskCreationView_Previews: PreviewProvider {
    static var previews: some View {
        newTaskCreationView(showCreationView: true)
    }
}
