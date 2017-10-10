//
//  Movie.swift
//  MovieNight
//
//  Created by Angus Muller on 29/09/2017.
//  Copyright © 2017 Angus Muller. All rights reserved.
//

import Foundation
import UIKit

enum MovieArtworkState {
    case placeholder
    case downloaded
    case failed
}

/// Stores the small amount of movie data from a discovery tmdb search.
class Movie: NSObject, JSONDecodable {
    let id: Int
    let title: String
    let overview: String
    //let genres: [Genre] // Currently does not record each movies genres, could do in future.
    let averageVote: Double
    var artworkUrl: String
    var artwork: UIImage?
    var artworkState = MovieArtworkState.placeholder
    
    required init?(json: [String: Any]) {
        
        struct Key {
            static let tmdbId = "id"
            static let tmdbTitle = "title"
            static let tmdbOverview = "overview"
            static let tmdbGenres = "genre_ids"
            static let tmdbAvereageVote = "vote_average"
            static let artworkUrl = "poster_path"
        }
        
        //Checks that keys in JSON exists, contain values and convertible to needed type
        guard let tmdbId = json[Key.tmdbId] as? Int,
            let tmdbTitle = json[Key.tmdbTitle] as? String,
            let tmdbOverview = json[Key.tmdbOverview] as? String,
            //let tmdbGenres = json[Key.tmdbGenres] as? [[String: Any]],
            let tmdbartworkUrl = json[Key.artworkUrl] as? String,
            let tmdbAverageVote = json[Key.tmdbAvereageVote] as? Double else {
                return nil
        }
        
        self.id = tmdbId
        self.title = tmdbTitle
        self.overview = tmdbOverview
        self.averageVote = tmdbAverageVote
        // As artwork url endpoint is only provided, add the full path onto the endpoint.
        self.artworkUrl = "https://image.tmdb.org/t/p/w92" + tmdbartworkUrl
    }
}
