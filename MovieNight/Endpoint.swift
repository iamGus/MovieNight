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
    /// A type that provides possible sort options for returned movie discovery search
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
    
    case genre()
    case discover(sortBy: TMDbSortType, genres: [Genre], runtimeGreater: Int, runtimeLess: Int, page: Int)
}

extension TMDb: Endpoint {
    var base: String {
    return "https://api.themoviedb.org"
    }
    
    var path: String {
        switch self {
        case .genre: return "/3/genre/movie/list"
        case .discover: return "/3/discover/movie"
        }
    }
    
    private var apiKey: String {
        return "9282f39f30c2df12f3a51c6bae00dcbc"
    }
    
    var queryItem: [URLQueryItem] {
        switch self {
        case .genre:
            return [
                URLQueryItem(name: "api_key", value: apiKey)
            ]
        case .discover(let sortBy, let genres, let runtimeGreater, let runtimeLess, let page):
            return [
                URLQueryItem(name: "api_key", value: apiKey),
                URLQueryItem(name: "sort_by", value: sortBy.description),
                URLQueryItem(name: "with_genres", value: genres.map({$0.id.description}).joined(separator: ",")), //Use map to take genres out of array and separate the id by ,
                URLQueryItem(name: "with_runtime.gte", value: runtimeGreater.description),
                URLQueryItem(name: "with_runtime.lte", value: runtimeLess.description),
                URLQueryItem(name: "page", value: page.description)
            ]
        }
    }
    
    
}

