//
//  User.swift
//  MovieNight
//
//  Created by Angus Muller on 02/10/2017.
//  Copyright © 2017 Angus Muller. All rights reserved.
//

import Foundation

enum User {
    case user1
    case user2
    case noneSelected
}

struct UserChoices {
    var chosenGenre: Genre?
    var maxRuntime: Runtime?
}

