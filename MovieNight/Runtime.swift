//
//  Runtime.swift
//  MovieNight
//
//  Created by Angus Muller on 29/09/2017.
//  Copyright © 2017 Angus Muller. All rights reserved.
//

import Foundation

// Model and data for Runtime, decided to keep data with model as of data never changing.

struct Runtime {
    
    let hoursInText: String
    let minutes: Int
}

struct RuntimeData {
    static var runtimeData: [Runtime] {
        let oneHour = Runtime(hoursInText: "1 Hour", minutes: 60)
        let oneHour15 = Runtime(hoursInText: "1 Hour 15 Min", minutes: 75)
        let oneHour30 = Runtime(hoursInText: "1 Hour 30 Min", minutes: 90)
        let oneHour45 = Runtime(hoursInText: "1 Hour 45 Min", minutes: 105)
        let twoHour = Runtime(hoursInText: "2 Hours", minutes: 120)
        let twoHour15 = Runtime(hoursInText: "2 Hour 15 Min", minutes: 135)
        let twoHour30 = Runtime(hoursInText: "2 Hour 30 Min", minutes: 150)
        let twoHour45 = Runtime(hoursInText: "2 Hour 45 Min", minutes: 165)
        let threeHour = Runtime(hoursInText: "3 Hour", minutes: 180)
        let threeHour15 = Runtime(hoursInText: "3 Hour 15 Min", minutes: 195)
        let threeHour30 = Runtime(hoursInText: "3 Hour 30 Min", minutes: 210)
        let threeHour45 = Runtime(hoursInText: "3 Hour 45 Min", minutes: 225)
        let fourHour = Runtime(hoursInText: "4 Hours", minutes: 240)
        
        return [oneHour, oneHour15, oneHour30, oneHour45, twoHour, twoHour15, twoHour30, twoHour45, threeHour, threeHour15, threeHour30, threeHour45, fourHour]
    }
}
