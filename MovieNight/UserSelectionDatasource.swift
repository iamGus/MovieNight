//
//  UserSelectionDatasource.swift
//  MovieNight
//
//  Created by Angus Muller on 02/10/2017.
//  Copyright © 2017 Angus Muller. All rights reserved.
//

import Foundation

class UserSelectionDatasource {
    private var user1 = UserChoices()
    private var user2 = UserChoices()
    
    func addGenre(user: User, genre: Genre) {
        switch user {
        case .user1: user1.chosenGenre = genre
        case .user2: user2.chosenGenre = genre
        case .noneSelected: return // DO I NEED TO SHOW ERROR
        }
    }
    
    func addRuntime(user: User, runtime: Runtime) {
        switch user {
        case .user1: user1.maxRuntime = runtime
        case .user2: user2.maxRuntime = runtime
        case .noneSelected: return // DO I NEED TO SHOW ERROR
        }
    }
    
    // Checks if called user has seleted both Genre and Runtime, returns true or false
    func isUserReady(user: User) -> Bool {
        switch user {
        case .user1:
            if user1.chosenGenre != nil && user1.maxRuntime != nil {
                return true
            } else {
                return false
            }
        case .user2:
            if let _ = user1.chosenGenre, (user2.maxRuntime != nil) {
                return true
            } else {
                return false
            }
        case .noneSelected: return false //Do I NEED TO SHOW ERROR
        }
    }
    
}
