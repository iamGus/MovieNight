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
    
    func getGenre(completion: @escaping (Result<[Genre], APIError>) -> Void) {
        
        let endpoint = TMDb.genre()
        let request = endpoint.request
        
        fetch(with: request, parse: { json -> [Genre] in
            guard let allGenres = json["genres"] as? [[String: Any]] else { return [] }
            return allGenres.flatMap { Genre(json: $0) }
        }, completion: completion)
    }
}
