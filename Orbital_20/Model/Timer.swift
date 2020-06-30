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

func secondsToHourMinSec(seconds: Int) -> String {
    let hours = "\(seconds / 3600)"
    let minutes = "\((seconds % 3600) / 60)"
    let seconds = "\((seconds % 3600) % 60)"
    let hourStamp = hours.count > 1 ? hours : "0" + hours
    let minuteStamp = minutes.count > 1 ? minutes : "0" + minutes
    let secondStamp = seconds.count > 1 ? seconds : "0" + seconds
    
    return "\(hourStamp) : \(minuteStamp) : \(secondStamp)"
}
