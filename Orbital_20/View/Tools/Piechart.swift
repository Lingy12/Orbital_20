//
//  Piechart.swift
//  Orbital_20
//
//  Created by Jerry Lin on 15/7/20.
//  Copyright © 2020 Jerry Lin. All rights reserved.
//

import SwiftUI

struct Piechart: View {
    @FetchRequest(entity: Module.entity(), sortDescriptors: []) var modList:FetchedResults<Module>
    
    var body: some View {
        
        VStack {
            Text("My Statistics")
                .fontWeight(.bold)
            
            Spacer()
            
            GeometryReader {g in
                ZStack {
                    ForEach(0..<self.modList.count) { i in
                        DrawShape(center: CGPoint(x:g.frame(in: .global).width / 2,y:g.frame(in: .global).height / 2), index: i)
                    }
                }.frame(height:360)
                    .padding(.top,20)
                    .clipShape(Circle())
                    .shadow(radius: 8)
            }
            
            VStack {
                ForEach(0..<self.modList.count) {i in
                    HStack {
                        Text(self.modList[i].moduleName ?? "")
                            .frame(width:100)
                        
                        GeometryReader { g in
                            HStack {
                                Spacer(minLength: 0)
                                
                                Rectangle()
                                    .fill(self.getColor(mod: self.modList[i]))
                                    .frame(width: self.getWidth(width: g.frame(in:.global).width, value: CGFloat(100 * self.getPercent(mod: self.modList[i]))), height: 10)
                                
                                Text(String(format:"\(Int(100 * self.getPercent(mod: self.modList[i])))","%.0f"))
                                    .fontWeight(.bold)
                                    .padding(.leading,10)
                            }
                        }
                        
                        
                    }
                }
                
            }.padding()
            
            Spacer()
        }//.edgesIgnoringSafeArea(.top)
    }
    
    private func getWidth(width:CGFloat,value:CGFloat) -> CGFloat {
        let temp = value/100.0
        return temp * width
    }
    
    private func getColor(mod:Module) -> Color {
        let modName = mod.moduleName ?? ""
        let hash = modName.hashValue
        let r = Double((hash & 0xFF0000) >> 16) / 255.0
        let g = Double((hash & 0x00FF00) >> 8) / 255.0
        let b = Double(hash & 0x0000FF) / 255.0
        return Color(red: Double(r), green: Double(g), blue: Double(b))
    }
    
    private func getPercent(mod:Module) -> Double {
        var sum:Double = 0
        
        for index in self.modList.indices {
            sum += modList[index].spentTime
        }
        
        if sum == 0 {
            return 0
        } else {
            return mod.spentTime/sum
        }
    }
}




struct Piechart_Previews: PreviewProvider {
    static var previews: some View {
        Piechart()
    }
}

struct DrawShape : View {
    var center : CGPoint
    var index : Int
    @FetchRequest(entity: Module.entity(), sortDescriptors: []) var modList:FetchedResults<Module>
    
    var body:some View {
        
        Path { path in
            path.move(to: self.center)
            path.addArc(center: self.center, radius: 180, startAngle: self.from(), endAngle: self.to(), clockwise: false)
        }.fill(self.getColor())
    }
    
    private func from() -> Angle {
        var temp:Double = 0
        
        if index == 0 {
            return Angle(degrees: 0)
        }
        
        for i in 0...index - 1 {
            temp += (self.getPercent(mod: modList[i])) * 360
        }
        
        return Angle(degrees: temp)
    }
    //Get the unique color associate with module name
    private func getColor() -> Color {
        let modName = modList[self.index].moduleName ?? ""
        let hash = modName.hashValue
        let r = Double((hash & 0xFF0000) >> 16) / 255.0
        let g = Double((hash & 0x00FF00) >> 8) / 255.0
        let b = Double(hash & 0x0000FF) / 255.0
        return Color(red: Double(r), green: Double(g), blue: Double(b))
    }
    
    private func to() -> Angle {
        var temp:Double = 0
        
        for i in 0...index {
            temp += (self.getPercent(mod: modList[i])) * 360
        }
        
        return Angle(degrees: temp)
        
    }
    
    private func getPercent(mod:Module) -> Double {
        var sum:Double = 0
        
        for index in self.modList.indices {
            sum += modList[index].spentTime
        }
        
        if sum == 0 {
            return 0
        } else {
            return mod.spentTime/sum
        }
    }
}


