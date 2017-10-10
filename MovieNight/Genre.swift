//
//  Genre.swift
//  MovieNight
//
//  Created by Angus Muller on 28/09/2017.
//  Copyright © 2017 Angus Muller. All rights reserved.
//

import Foundation

class Genre: NSObject, JSONDecodable {
    let id: Int
    let name: String
    
    required init?(json: [String: Any]) {
        
        struct Key {
            static let tmdbId = "id"
            static let tmdbName = "name"
        }
        
        //Checks that keys in JSON exists, contain values and convertible to needed type
        guard let tmdbId = json[Key.tmdbId] as? Int,
            let tmdbName = json[Key.tmdbName] as? String else {
                return nil
        }
        
        self.id = tmdbId
        self.name = tmdbName
    }
}


