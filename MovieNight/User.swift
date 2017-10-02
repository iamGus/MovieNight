//
//  User.swift
//  MovieNight
//
//  Created by Angus Muller on 02/10/2017.
//  Copyright © 2017 Angus Muller. All rights reserved.
//

import Foundation

struct User {
    var chosenGenre: Genre
    var maxRuntime: Runtime?
}

extension User {
    init(chosenGenre: Genre) {
        self.chosenGenre = chosenGenre
        self.maxRuntime = nil
    }
}
