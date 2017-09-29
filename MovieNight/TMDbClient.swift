//
//  TMDbClient.swift
//  MovieNight
//
//  Created by Angus Muller on 28/09/2017.
//  Copyright © 2017 Angus Muller. All rights reserved.
//

import Foundation

class TMDbClient: APIClient {
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    /// Retrive all genres from TMDb
    func getGenre(completion: @escaping (Result<[Genre], APIError>) -> Void) {
        
        let endpoint = TMDb.genre()
        let request = endpoint.request
        
        fetch(with: request, parse: { json -> [Genre] in
            guard let allGenres = json["genres"] as? [[String: Any]] else { return [] }
            return allGenres.flatMap { Genre(json: $0) }
        }, completion: completion)
    }
    
    // Retrive movie suggestions from TMDb
    func getMovieSuggestions(sortBy: TMDb.TMDbSortType, genres: [Genre], runtimeGreater: Int, runTimeLess: Int, page: Int, completion: @escaping (Result<[Movie], APIError>) -> Void) {
        
        let endpoint = TMDb.dicover(sortBy: sortBy, genres: genres, runtimeGreater: runtimeGreater, runtimeLess: runTimeLess, page: page)
        let request = endpoint.request
        
        fetch(with: request, parse: { json -> [Movie] in
            guard let allMovies = json["results"] as? [[String: Any]] else { return [] }
            return allMovies.flatMap { Movie(json: $0) }
        }, completion: completion)
    }
}
