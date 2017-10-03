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
            if user2.chosenGenre != nil && user2.maxRuntime != nil {
                return true
            } else {
                return false
            }
        case .noneSelected: return false //Do I NEED TO SHOW ERROR
        }
    }
    
    // Reset stored peoperties for user selectio back to nil
    func resetUsers() {
        user1.chosenGenre = nil
        user1.maxRuntime = nil
        user2.chosenGenre = nil
        user2.maxRuntime = nil
    }
    
    //Mark: - Returning results for film search
    
    //Return both user Genres
    func chosenGenres() -> [Genre] {
        if let user1Genre = user1.chosenGenre, let user2Genre = user2.chosenGenre {
            return [user1Genre, user2Genre]
        }
        return [] // DO I NEED TO DO ANYTHING HERE?
    }
    
    func averageMaxRuntime() -> Int {
        if let user1Runtime = user1.maxRuntime, let user2Runtime = user2.maxRuntime {
            let averageRuntime = (user1Runtime.minutes + user2Runtime.minutes) / 2
            print(averageRuntime)
            return averageRuntime
        }
        
        return 130 // DO I NEED TO DO ANYTHING HERE?
    }
    
}
