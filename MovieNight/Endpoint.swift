//
//  Endpoint.swift
//  MovieNight
//
//  Created by Angus Muller on 28/09/2017.
//  Copyright © 2017 Angus Muller. All rights reserved.
//

import Foundation

/// A type that provides URLRequests for defined API endpoints
protocol Endpoint {
    var base: String { get }
    var path: String { get }
    var queryItem: [URLQueryItem] { get }
}

extension Endpoint {
    /// Returns an instance of URLComponents containing the base URL, path and
    /// query items provided
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        components.queryItems = queryItem
        
        return components
    }
    
    /// Returns an instance of URLRequest encapsulating the endpoint URL. This
    /// URL is obtained through the `urlComponents` object.
    var request: URLRequest {
        let url = urlComponents.url!
        return URLRequest(url: url)
    }
}

enum TMDb {
    /// A type that provides possible sort options for returned movie dicovery search
    enum TMDbSortType: CustomStringConvertible {
        case popularityAsc, popularityDesc, releaseDateAsc, releaseDateDesc, revenueAsc, revenueDesc, voteAverageAsc, voteAverageDesc, voteCountAsc, voteCountDesc
        
        var description: String {
            switch self {
            case .popularityAsc: return "popularity.asc"
            case .popularityDesc: return "popularity.desc"
            case .releaseDateAsc: return "release_date.asc"
            case .releaseDateDesc: return "release_date.desc"
            case .revenueAsc: return "revenue.asc"
            case .revenueDesc: return "revenue.desc"
            case .voteAverageAsc: return "vote_average.asc"
            case .voteAverageDesc: return "vote_average.desc"
            case .voteCountAsc: return "vote_count.asc"
            case .voteCountDesc: return "vote_count.desc"
            }
        }
    }
    
    case genre(apiKey: String) //NOTE SHOULD THIS BE TYPE ApiKey?
    case dicover(apiKey: String, sortBy: TMDbSortType, genres: Genres, runtimeGreater: Int, runtimeLess: Int, page: Int) //NOTE: Still to create Genre type
}

extension TMDb: Endpoint {
    var base: String {
    return "https://api.themoviedb.org"
    }
    
    var path: String {
        switch self {
        case .genre: return "/genre/movie/list"
        case .dicover: return "/discover/movie"
        }
    }
    
}

