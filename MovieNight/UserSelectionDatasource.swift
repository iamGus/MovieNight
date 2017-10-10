//
//  UserSelectionDatasource.swift
//  MovieNight
//
//  Created by Angus Muller on 02/10/2017.
//  Copyright © 2017 Angus Muller. All rights reserved.
//

// User selection choices stored here and also functions to pull data out

import Foundation

class UserSelectionDatasource {
    private var user1 = UserChoices()
    private var user2 = UserChoices()
    
    func addGenre(user: User, genre: Genre) {
        switch user {
        case .user1: user1.chosenGenre = genre
        case .user2: user2.chosenGenre = genre
        case .noneSelected: return // Maybe add additional error handling
        }
    }
    
    func addRuntime(user: User, runtime: Runtime) {
        switch user {
        case .user1: user1.maxRuntime = runtime
        case .user2: user2.maxRuntime = runtime
        case .noneSelected: return // Maybe add additional error handling
        }
    }
    
    // Checks if called user has selected both Genre and Runtime, returns true or false
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
        case .noneSelected: return false // Maybe add additional error handling
        }
    }
    
    // Check if both users have selected both Genre and Runtime
    func areUsersReady() -> Bool {
        if isUserReady(user: .user1) == true && isUserReady(user: .user2) == true {
            return true
        } else {
            return false
        }
    }
    
    // Reset stored properties for user selection back to nil
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
            // If both users selected same Genre then only return one instance of that genre
            if user1Genre.id == user2Genre.id {
                return [user1Genre]
            }
            // Otherwise return both genres
            return [user1Genre, user2Genre]
        }
        return [] // This should never happen as users can only get to movie results if both have entered choices.
    }
    
    func averageMaxRuntime() -> Int {
        if let user1Runtime = user1.maxRuntime, let user2Runtime = user2.maxRuntime {
            let averageRuntime = (user1Runtime.minutes + user2Runtime.minutes) / 2
            print(averageRuntime)
            return averageRuntime
        }
        
        return 130 // This should never happen as users can only get to movie results if both have entered choices.
    }
    
}
