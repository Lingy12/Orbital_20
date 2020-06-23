//
//  Timer.swift
//  Orbital_20
//
//  Created by Jerry Lin on 23/6/20.
//  Copyright © 2020 Jerry Lin. All rights reserved.
//

import Foundation

enum TimerMode {
    case running
    case paused
    case initial
}

func secondsToMinSec(seconds: Int) -> String {
    let minutes = "\((seconds % 3600) / 60)"
    let seconds = "\((seconds % 3600) % 60)"
    let minuteStamp = minutes.count > 1 ? minutes : "0" + minutes
    let secondStamp = seconds.count > 1 ? seconds : "0" + seconds
    
    return "\(minuteStamp) : \(secondStamp)"
}
